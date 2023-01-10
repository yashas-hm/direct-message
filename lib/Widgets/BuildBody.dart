import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Utils/AdID.dart';
import '../Utils/Utils.dart';

class BuildBody extends StatefulWidget {
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  TextEditingController codeController = TextEditingController();
  late AnimationController animationController;
  late Animation animation;
  bool adLoading = true;
  FocusNode phoneFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

  late final BannerAd bannerAd;

  late final InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    InterstitialAd.load(
      adUnitId: Platform.isIOS ? AdID().resumeIOS : AdID().resumeAndroid,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          this.interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
    read(codeController);

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 300.0, end: 200.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    phoneFocus.addListener(() {
      if (phoneFocus.hasFocus) {
        codeFocus.unfocus();
        if (animation.value != 200.0) {
          animationController.forward();
        }
      }
    });

    codeFocus.addListener(() {
      if (codeFocus.hasFocus) {
        phoneFocus.unfocus();
        if (animation.value != 200.0) {
          animationController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    bannerAd.dispose();
    interstitialAd.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      interstitialAd.show();
    }
  }

  Future<void> loadBanner(BuildContext ctx) async {
    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(ctx).size.width.toInt());
    bannerAd = BannerAd(
      adUnitId: Platform.isIOS ? AdID().bannerIOS : AdID().bannerAndroid,
      size: adSize??AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animation.value == 200.0) {
          animationController.reverse();
        }
        phoneFocus.unfocus();
        codeFocus.unfocus();
      },
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            height: animation.value,
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(30),
            child: Image.asset(
              'assets/app_icon/app_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text(
              'Enter number with country code',
              style: TextStyle(
                color: Platform.isIOS
                    ? CupertinoTheme.of(context).primaryContrastingColor
                    : Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
            ),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                child: Platform.isIOS
                    ? CupertinoTextField(
                        controller: codeController,
                        placeholder: 'Code',
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CupertinoTheme.of(context)
                                .primaryContrastingColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        maxLength: 3,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                        keyboardType: TextInputType.phone,
                        cursorColor:
                            CupertinoTheme.of(context).primaryContrastingColor,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (term) {
                          codeFocus.unfocus();
                          FocusScope.of(context).requestFocus(phoneFocus);
                        },
                        focusNode: codeFocus,
                      )
                    : TextField(
                        controller: codeController,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Code',
                          focusColor: Theme.of(context).colorScheme.secondary,
                          counter: Text(''),
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
                        onSubmitted: (term) {
                          codeFocus.unfocus();
                          FocusScope.of(context).requestFocus(phoneFocus);
                        },
                        focusNode: codeFocus,
                      ),
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                width: 80,
              ),
              Container(
                child: Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: 'Number',
                        controller: controller,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: CupertinoTheme.of(context)
                                .primaryContrastingColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        maxLength: 14,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                        keyboardType: TextInputType.phone,
                        cursorColor:
                            CupertinoTheme.of(context).primaryContrastingColor,
                        onEditingComplete: () =>
                            pasteCheck(controller, codeController),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (term) {
                          phoneFocus.unfocus();
                          if (animation.value == 200.0) {
                            animationController.reverse();
                          }
                        },
                        focusNode: phoneFocus,
                      )
                    : TextField(
                        controller: controller,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Number',
                          counter: Text(''),
                          focusColor: Theme.of(context).colorScheme.secondary,
                          fillColor: Color.fromARGB(255, 57, 62, 70),
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
                        onEditingComplete: () =>
                            pasteCheck(controller, codeController),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (term) {
                          phoneFocus.unfocus();
                          if (animation.value == 200.0) {
                            animationController.reverse();
                          }
                        },
                        focusNode: phoneFocus,
                      ),
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width - 150,
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Platform.isIOS
              ? CupertinoButton(
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    openerDetails(context, controller, codeController);
                  },
                  color: CupertinoTheme.of(context).primaryContrastingColor,
                  padding: EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(40),
                )
              : MaterialButton(
                  onPressed: () {
                    openerDetails(context, controller, codeController);
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder(
                future: loadBanner(context),
                builder: (ctx, state) {
                  if(state.connectionState == ConnectionState.done){
                    bannerAd.load();
                    return Container(
                      child: AdWidget(
                        ad: bannerAd,
                      ),
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                    );
                  }else{
                    return Container(
                      child: const CircularProgressIndicator(),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
