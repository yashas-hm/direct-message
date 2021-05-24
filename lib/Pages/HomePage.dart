import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Utils/AdID.dart';
import '../Widgets/BuildScaffold.dart';
import '../Utils/Utils.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  TextEditingController _controller = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  final BannerAd bannerAd = BannerAd(
    adUnitId: Platform.isIOS ? AdID().bannerIOS : AdID().bannerAndroid,
    size: Platform.isIOS ? AdSize.smartBannerPortrait : AdSize.smartBanner,
    request: AdRequest(
      testDevices: ['C9971B06E2748F2EC489FB804F9EEC39'],
    ),
    listener: AdListener(),
  );

  final InterstitialAd interstitialAd = InterstitialAd(
    adUnitId: Platform.isIOS ? AdID().resumeIOS : AdID().resumeAndroid,
    listener: AdListener(),
    request: AdRequest(
      testDevices: ['C9971B06E2748F2EC489FB804F9EEC39'],
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    bannerAd.load();
    interstitialAd.load();
    read(_codeController);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    bannerAd.dispose();
    interstitialAd.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      interstitialAd.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context, _controller, _codeController, bannerAd);
  }
}
