import 'dart:io';

import 'package:direct_message/core/constants/app_colors.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/secrets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
      adUnitId: Platform.isIOS ? iOSBannerAdId : androidBannerAdID,
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
          ? Container(
              color: Colors.black26,
            )
          : isLoading!
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(
                      blue,
                    ),
                  ),
                )
              : SizedBox(
                  width: context.width,
                  child: AdWidget(
                    ad: bannerAd!,
                  ),
                ),
    );
  }
}
