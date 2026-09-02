import 'dart:io';

import 'package:country_calling_code_kit/country_calling_code_kit.dart';
import 'package:direct_message/theme/sizes.dart';
import 'package:direct_message/utilities/extensions.dart';
import 'package:direct_message/utilities/preferences.dart';
import 'package:direct_message/view/ad_banner.dart';
import 'package:direct_message/view/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

const String appLogo = 'assets/images/logo.svg';

class OpenWaScreen extends StatefulWidget {
  const OpenWaScreen({super.key});

  @override
  State<OpenWaScreen> createState() => _OpenWaScreenState();
}

class _OpenWaScreenState extends State<OpenWaScreen>
    with WidgetsBindingObserver {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();

  InterstitialAd? interstitialAd;
  int phoneLength = 0;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: Platform.isIOS ? Ads.iosInterstitial : Ads.androidInterstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    loadAd();
    _prefillCountryCode();
    super.initState();
  }

  Future<void> _prefillCountryCode() async {
    countryCodeController.text = await Preferences.getCountryCode ?? '';
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (interstitialAd != null) {
        interstitialAd?.show();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    phoneController.dispose();
    countryCodeController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Direct Message',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: Sizes.fontXl,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(Sizes.spacingXxl),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: context.height / 2.5,
                  minHeight: context.height / 5.5,
                ),
                child: SvgPicture.asset(
                  appLogo,
                  colorFilter: ColorFilter.mode(
                    context.colors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Gap(Sizes.spacingXxl),
            Row(
              children: [
                Container(
                  height: Sizes.controlHeight,
                  margin: const EdgeInsets.only(left: Sizes.spacingLg),
                  alignment: Alignment.centerLeft,
                  width: context.width / 6,
                  child: TextField(
                    controller: countryCodeController,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    onTap: _showPicker,
                    decoration: InputDecoration(
                      labelText: 'Code',
                      focusColor: Theme.of(context).colorScheme.secondary,
                      counterText: '',
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.radiusMd),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: Sizes.borderThin,
                        ),
                      ),
                    ),
                    maxLength: 3,
                    keyboardType: TextInputType.phone,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: Sizes.controlHeight,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                      right: Sizes.spacingLg,
                      left: Sizes.spacingSm,
                    ),
                    child: TextField(
                      controller: phoneController,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Number',
                        counterText: '',
                        focusColor: Theme.of(context).colorScheme.secondary,
                        fillColor: context.colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.radiusMd),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: Sizes.borderThin,
                          ),
                        ),
                      ),
                      maxLength: 14,
                      keyboardType: TextInputType.phone,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      onChanged: (value) {
                        if (value.length - 1 == phoneLength) {
                          _pasteCheck();
                        }
                        phoneLength = value.length;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
              ],
            ),
            Gap(Sizes.spacingXxl),
            Expanded(child: Container()),
            Gap(Sizes.spacingXxl),
            GestureDetector(
              onTap: _openerDetails,
              child: Container(
                height: Sizes.controlHeight,
                width: Sizes.controlHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.primary,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.send, color: context.colors.onPrimary),
              ),
            ),
            Gap(Sizes.spacingXxl),
          ],
        ),
      ),
      bottomNavigationBar: const BannerAdvert(),
    );
  }

  void _showPicker() async {
    final country = await showCountryPickerModalSheet(
      context: context,
      splashColor: context.colors.primary.withValues(alpha: 0.3),
      flagCornerRadius: Sizes.radiusXs,
    );
    if (country != null) {
      countryCodeController.text = country.callCode;
      Preferences.setCountryCode(country.callCode);
    }
  }

  void _pasteCheck() {
    final text = phoneController.text;
    if (text.length > 10) {
      phoneController.text = text.substring(text.length - 10);
      countryCodeController.text = text.substring(0, text.length - 10);
    }
  }

  void _openerDetails() {
    final phone = phoneController.text;
    var code = '';
    if (countryCodeController.text != '') {
      code = countryCodeController.text.startsWith('+')
          ? countryCodeController.text.substring(1)
          : countryCodeController.text;
    }

    if (phone == '') {
      showSnackBar('Number cannot be empty');
    } else if (phone.length < 10) {
      showSnackBar('Invalid Number');
    } else if (code == '') {
      showSnackBar('Enter Country Code');
    } else {
      _openWhatsapp(phone, code);
    }
  }

  Future<void> _openWhatsapp(String phone, String code) async {
    if (code.contains('+')) code = code.replaceAll('+', '');
    final uri = Uri.parse('https://api.whatsapp.com/send?phone=$code$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      showSnackBar('Some unexpected error occurred');
    }
  }

  void showSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.spacingMd,
            vertical: Sizes.spacingXxs,
          ),
          dismissDirection: DismissDirection.vertical,
          content: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: Sizes.spacing3xl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.close,
                  size: Sizes.iconLg,
                  color: Colors.redAccent,
                ),
                const Gap(Sizes.spacingMd),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: Sizes.fontMd,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
