import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './BuildAppBar.dart';
import './BuildBody.dart';

Widget buildScaffold(BuildContext context) {
  return Platform.isIOS
      ? CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: buildAppbar(context) as CupertinoNavigationBar,
          child: BuildBody(),
        )
      : Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppbar(context) as AppBar,
          body: BuildBody(),
        );
}
