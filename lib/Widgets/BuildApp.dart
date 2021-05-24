import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/HomePage.dart';

Widget buildApp(BuildContext context) {
  return Platform.isIOS
      ? CupertinoApp(
          title: 'Direct Message',
          theme: CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: Color.fromARGB(255, 249, 249, 249),
            scaffoldBackgroundColor: Color.fromARGB(255, 249, 249, 249),
            primaryContrastingColor: Color.fromARGB(255, 236, 88, 97),
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        )
      : MaterialApp(
          title: 'Direct Message',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color.fromARGB(255, 249, 249, 249),
            scaffoldBackgroundColor: Color.fromARGB(255, 249, 249, 249),
            accentColor: Color.fromARGB(255,  236, 88, 97),
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        );
}
