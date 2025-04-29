import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/utilities/utils.dart';
import 'package:flutter/material.dart';

const blueLight = Color.fromARGB(255, 45, 143, 237);

const blueDark = Color.fromARGB(255, 30, 132, 246);

const Color bgDark = Color(0xFF151515);

const Color darkElement = Color(0xFF2A2A2A);

const Color bgLight = Color(0xFFFCFCFC);

const Color lightElement = Color(0xFFF6F6F6);

Color get backgroundColor => Theme.of(globalContext).scaffoldBackgroundColor;

Color get element => Theme.of(globalContext).colorScheme.secondary;

Color get blue => Theme.of(globalContext).primaryColor;

Color get textColor => themeMode.value == ThemeMode.light ? bgDark : bgLight;
