import 'package:direct_message/screens/app/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DirectMessageApp(
    child: SplashScreen(),
  ));
}
