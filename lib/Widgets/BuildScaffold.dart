import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'BuildAppBar.dart';
import './BuildBody.dart';

Widget buildScaffold(BuildContext context, TextEditingController controller,
    TextEditingController codeController, BannerAd banner) {
  return Platform.isIOS
      ? CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: buildAppbar(context) as CupertinoNavigationBar,
          child: buildBody(context, controller, codeController, banner),
        )
      : Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppbar(context) as AppBar,
          body: buildBody(context, controller, codeController, banner),
        );
}
