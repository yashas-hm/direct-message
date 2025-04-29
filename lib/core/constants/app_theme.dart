import 'package:direct_message/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resize/resize.dart';

class CustomAppTheme {
  CustomAppTheme(this.context);

  final BuildContext context;

  ThemeData get light => ThemeData(
        primaryColor: blueLight,
        scaffoldBackgroundColor: bgLight,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: bgDark,
                displayColor: bgDark,
              ),
        ),
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: lightElement,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 5.sp,
          iconTheme: const IconThemeData(
            color: bgDark,
          ),
          backgroundColor: lightElement,
          titleTextStyle: GoogleFonts.roboto(
            fontSize: 30.sp,
            color: bgDark,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: blueLight,
          primary: blueLight,
          secondary: lightElement,
          tertiary: bgDark,
          brightness: Brightness.light,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: blueLight,
          cursorColor: darkElement,
          selectionColor: blueLight.withValues(alpha: 0.3),
        ),
      );

  ThemeData get dark => ThemeData(
        primaryColor: blueDark,
        scaffoldBackgroundColor: bgDark,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: bgLight,
                displayColor: bgLight,
              ),
        ),
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: darkElement,
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 5.sp,
          iconTheme: const IconThemeData(
            color: bgLight,
          ),
          backgroundColor: darkElement,
          titleTextStyle: GoogleFonts.pacifico(
            fontSize: 30.sp,
            color: bgLight,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: blueDark,
          primary: blueDark,
          secondary: darkElement,
          tertiary: bgLight,
          brightness: Brightness.dark,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: blueDark,
          cursorColor: lightElement,
          selectionColor: blueDark.withValues(alpha: 0.3),
        ),
      );
}
