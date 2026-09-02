import 'dart:io';

import 'package:direct_message/utilities/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  Ads._();

  static const String androidBanner = kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-1043871887446386/4406111654';

  static const String iosBanner = kDebugMode
      ? 'ca-app-pub-3940256099942544/2934735716'
      : 'ca-app-pub-1043871887446386/7332422230';

  static const String androidInterstitial = kDebugMode
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-1043871887446386/1779948316';

  static const String iosInterstitial = kDebugMode
      ? 'ca-app-pub-3940256099942544/4411468910'
      : 'ca-app-pub-1043871887446386/8576510705';
}

class BannerAdvert extends StatefulWidget {
  const BannerAdvert({super.key});

  @override
  State<BannerAdvert> createState() => _BannerAdvertState();
}

class _BannerAdvertState extends State<BannerAdvert> {
  BannerAd? bannerAd;
  bool? isLoading = true;

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: Platform.isIOS ? Ads.iosBanner : Ads.androidBanner,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => isLoading = false),
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          debugPrint(err.toString());
          setState(() => isLoading = null);
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height / 15,
      child: isLoading == null
          ? Container(color: Colors.black26)
          : isLoading!
          ? Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(context.colors.primary),
              ),
            )
          : SizedBox(
              width: context.width,
              child: AdWidget(ad: bannerAd!),
            ),
    );
  }
}
