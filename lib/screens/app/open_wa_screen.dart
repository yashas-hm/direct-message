import 'dart:io';

import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:direct_message/core/constants/app_colors.dart';
import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/core/utilities/utils.dart';
import 'package:direct_message/secrets.dart';
import 'package:direct_message/widgets/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:resize/resize.dart';

class OpenWaScreen extends StatefulWidget {
  const OpenWaScreen({super.key});

  @override
  State<OpenWaScreen> createState() => _OpenWaScreenState();
}

class _OpenWaScreenState extends State<OpenWaScreen>
    with WidgetsBindingObserver {
  InterstitialAd? interstitialAd;
  int phoneLength = 0;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: Platform.isIOS ? iOSInterstitialAdId : androidInterstitialAdId,
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
    super.initState();
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
    WidgetsBinding.instance.removeObserver(this);
    interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                appName,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            DayNightSwitch(
              onChange: (_) {
                toggleTheme(context);
              },
              duration: 600.milliseconds,
              size: 25.sp,
              initiallyDark: themeMode.value == ThemeMode.dark,
            ),
          ],
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
            Gap(30.sp),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: context.height / 2.5,
                    minHeight: context.height / 5.5),
                child: SvgPicture.asset(
                  appLogo,
                  colorFilter: ColorFilter.mode(
                    blue,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Gap(30.sp),
            Row(
              children: [
                Container(
                  height: 60.sp,
                  margin: EdgeInsets.only(left: 20.sp),
                  alignment: Alignment.centerLeft,
                  width: context.width / 6,
                  child: TextField(
                    controller: countryCodeController,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    onTap: () => countryCodePicker(context),
                    decoration: InputDecoration(
                      labelText: 'Code',
                      focusColor: Theme.of(context).colorScheme.secondary,
                      counterText: '',
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
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
                    height: 60.sp,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      right: 20.sp,
                      left: 10.sp,
                    ),
                    child: TextField(
                      controller: phoneController,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Number',
                        counterText: '',
                        focusColor: Theme.of(context).colorScheme.secondary,
                        fillColor: element,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                        ),
                      ),
                      maxLength: 14,
                      keyboardType: TextInputType.phone,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      onChanged: (value) {
                        if (value.length - 1 == phoneLength) {
                          pasteCheck();
                        }
                        phoneLength = value.length;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
              ],
            ),
            Gap(30.sp),
            Expanded(
              child: Container(),
            ),
            Gap(30.sp),
            GestureDetector(
              onTap: openerDetails,
              child: Container(
                height: 60.sp,
                width: 60.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: blue,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.send,
                  color: bgLight,
                ),
              ),
            ),
            Gap(30.sp),
          ],
        ),
      ),
      bottomNavigationBar: const BannerAdvert(),
    );
  }
}
