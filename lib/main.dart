import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/constants/app_theme.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

void main() {
  runApp(const DirectMessage());
}

class DirectMessage extends StatelessWidget {
  const DirectMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final currSize = Size(context.width, context.height);

    Size size = const Size(410, 910);

    if (currSize.aspectRatio < size.aspectRatio) {
      size = currSize;
    }

    return Resize(
      builder: () => ValueListenableBuilder(
        valueListenable: themeMode,
        builder: (_, theme, __) {
          return MaterialApp(
            navigatorKey: globalKey,
            theme: CustomAppTheme(context).light,
            darkTheme: CustomAppTheme(context).dark,
            themeMode: theme,
            debugShowCheckedModeBanner: false,
            title: 'Direct Message',
            home: const SplashScreen(),
          );
        }
      ),
      allowtextScaling: false,
      size: size,
    );
  }
}

