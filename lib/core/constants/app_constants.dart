import 'package:flutter/material.dart';

final TextEditingController phoneController = TextEditingController();

final TextEditingController countryCodeController = TextEditingController();

final GlobalKey<NavigatorState> globalKey = GlobalKey();

final ValueNotifier<ThemeMode> themeMode =
    ValueNotifier<ThemeMode>(ThemeMode.system);

const String darkModePrefTag = 'darkMode';

const String countryCodePrefTag = 'countryCode';

const String appLogo = 'assets/images/logo.svg';

const String appName = 'Direct Message';
