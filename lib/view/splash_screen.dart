import 'package:direct_message/theme/theme.dart';
import 'package:direct_message/utilities/extensions.dart';
import 'package:direct_message/view/open_wa_screen.dart';
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

    await ThemeController.instance.init(context);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, _, _) => const OpenWaScreen(),
          transitionsBuilder: (_, animation, _, child) => FadeTransition(
            opacity: animation.drive(
              Tween<double>(
                begin: 0,
                end: 1,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          ),
          transitionDuration: Durations.short4,
          reverseTransitionDuration: Durations.short4,
        ),
      );
    }
  }

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: Durations.long1,
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
              curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
            ),
          ),
          child: SlideTransition(
            position:
                Tween<Offset>(
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
              colorFilter: ColorFilter.mode(
                context.colors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
