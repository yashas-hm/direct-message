import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import 'core/utilities/utils.dart';

class DirectMessageApp extends StatelessWidget {
  const DirectMessageApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Resize(
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
              home: child,
            );
          },
        ),
        allowtextScaling: false,
        size: getAppDimensions(context),
      );
}
