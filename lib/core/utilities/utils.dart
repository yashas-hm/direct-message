import 'package:country_calling_code_picker/picker.dart';
import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/core/utilities/preference_utils.dart';
import 'package:direct_message/core/utilities/snackbar_utils.dart';
import 'package:direct_message/screens/open_wa_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> initApp(BuildContext context) async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await checkDarkMode(context);

  countryCodeController.text = await getCountryCode ?? '';

  if (context.mounted) {
    navigateOff(
      context,
      const OpenWaScreen(),
    );
  }
}

void pasteCheck() {
  final String text = phoneController.text;
  if (text.length > 10) {
    phoneController.text = text.substring(text.length - 10);
    countryCodeController.text = text.substring(0, text.length - 10);
  }
}

void openWhatsapp(final String phone, String code) async {
  if (!code.contains('+')) {
    code = '+$code';
  }
  String url = "https://api.whatsapp.com/send?phone=$code$phone";

  final Uri encoded = Uri.parse(url);
  if (await canLaunchUrl(encoded)) {
    await launchUrl(
      encoded,
      mode: LaunchMode.externalApplication,
    );
  } else {
    showSnackBar('Some unexpected error occurred');
    throw 'Cannot open $encoded';
  }
}

void openerDetails() {
  String phone = phoneController.text;
  String code = '';
  if (countryCodeController.text != '') {
    if (countryCodeController.text[0] != '+') {
      code = countryCodeController.text;
    } else {
      code = countryCodeController.text
          .substring(1, countryCodeController.text.length);
    }
  }

  if (phone == '') {
    showSnackBar('Enter Number');
  } else if (phone.length < 10) {
    showSnackBar('Invalid Number. Greater than 10 digits');
  } else if (code == '') {
    showSnackBar('Enter Country Code');
  } else {
    openWhatsapp(phone, code);
  }
}

Future<void> checkDarkMode(BuildContext context) async {
  bool? prefDarkBool = await isDarkModePref;
  ThemeMode newTheme = ThemeMode.system;

  if (prefDarkBool != null) {
    if (prefDarkBool) {
      newTheme = ThemeMode.dark;
    } else {
      newTheme = ThemeMode.light;
    }
  } else {
    late bool isDark;
    if (context.mounted) {
      if (context.isSystemDark) {
        newTheme = ThemeMode.dark;
        isDark = true;
      } else {
        newTheme = ThemeMode.light;
        isDark = false;
      }
      setIsDarkModePref(isDark);
    }
  }

  themeMode.value = newTheme;
}

void toggleTheme(BuildContext context) {
  ThemeMode newTheme = ThemeMode.system;
  bool isDark = false;

  if (themeMode.value == ThemeMode.light) {
    newTheme = ThemeMode.dark;
    isDark = true;
  } else {
    newTheme = ThemeMode.light;
    isDark = false;
  }

  setIsDarkModePref(isDark);
  themeMode.value = newTheme;
}

void countryCodePicker(BuildContext context) async {
  final country = await showCountryPickerSheet(
    context,
  );
  if (country != null) {
    countryCodeController.text = country.callingCode;
    setCountryCode(country.callingCode);
  }
}

PageRouteBuilder pageRouteBuilder(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation.drive(
          Tween<double>(begin: 0, end: 1).chain(
            CurveTween(
              curve: Curves.easeInOut,
            ),
          ),
        ),
        child: child,
      ),
      transitionDuration: 600.milliseconds,
      reverseTransitionDuration: 600.milliseconds,
    );

void navigateTo(
  BuildContext context,
  Widget page,
) =>
    Navigator.push(
      context,
      pageRouteBuilder(page),
    );

void navigateOffAll(
  BuildContext context,
  Widget page,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      pageRouteBuilder(page),
      (_) => false,
    );

void navigateOff(
  BuildContext context,
  Widget page,
) =>
    Navigator.pushReplacement(
      context,
      pageRouteBuilder(page),
    );

BuildContext get globalContext => globalKey.currentContext!;
