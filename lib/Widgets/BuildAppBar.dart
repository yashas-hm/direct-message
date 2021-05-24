import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildAppbar(BuildContext context) {
  return Platform.isIOS
      ? CupertinoNavigationBar(
          middle: Text(
            'Direct Message',
            style: TextStyle(
                color: CupertinoTheme.of(context).primaryContrastingColor),
          ),
          backgroundColor: CupertinoTheme.of(context).primaryColor,
        )
      : AppBar(
          title: Text(
            'Direct Message',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        );
}
