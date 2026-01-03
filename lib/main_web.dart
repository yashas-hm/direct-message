import 'package:direct_message/screens/web/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const DirectMessageApp(
    child: Homepage(),
  ));
}
