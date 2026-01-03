import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/core/utilities/preference_utils.dart';
import 'package:direct_message/core/utilities/utils.dart';
import 'package:direct_message/screens/app/open_wa_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;

  Future<void> initApp(BuildContext context) async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await checkDarkMode(context);

    countryCodeController.text = await getCountryCode ?? '';

    if (context.mounted) {
      navigateOff(
        context,
        const OpenWaScreen(),
      );
    }
  }

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: 800.milliseconds,
    );
    animController.forward();
    animController.addStatusListener((status) {
      if (animController.isCompleted) {
        initApp(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: context.height,
        width: context.width,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animController,
              curve: const Interval(
                0.3,
                0.8,
                curve: Curves.easeIn,
              ),
            ),
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-3, 5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animController,
                curve: Curves.bounceIn,
              ),
            ),
            child: SvgPicture.asset(
              appLogo,
              height: context.width / 2.5,
              colorFilter: const ColorFilter.mode(
                Colors.blue,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
