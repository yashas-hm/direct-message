import 'package:direct_message/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:direct_message/theme/theme.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DirectMessageApp());
}

class DirectMessageApp extends StatelessWidget {
  const DirectMessageApp({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: ThemeController.instance.mode,
    builder: (_, mode, _) {
      return MaterialApp(
        theme: DmTheme(context).light,
        darkTheme: DmTheme(context).dark,
        themeMode: mode,
        debugShowCheckedModeBanner: false,
        title: 'Direct Message',
        home: const SplashScreen(),
      );
    },
  );
}
