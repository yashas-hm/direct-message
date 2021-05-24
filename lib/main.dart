import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Widgets/BuildApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(EasyWhatsapp());
}

class EasyWhatsapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildApp(context);
  }
}
