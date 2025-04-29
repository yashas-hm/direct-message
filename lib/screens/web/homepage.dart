import 'dart:math' as math;

import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:direct_message/core/constants/app_colors.dart';
import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/core/utilities/utils.dart';
import 'package:direct_message/widgets/lava.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    checkDark();
    super.initState();
  }

  void checkDark() async {
    await checkDarkMode(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: HomeLandscape(),
      ),
    );
  }
}

class HomeLandscape extends StatefulWidget {
  const HomeLandscape({super.key});

  @override
  State<HomeLandscape> createState() => _HomeLandscapeState();
}

class _HomeLandscapeState extends State<HomeLandscape>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCtr;

  @override
  void initState() {
    animCtr = AnimationController(
      vsync: this,
      duration: 1000.milliseconds,
    );
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => animCtr.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    animCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: context.width,
              height: context.height * .9,
              color: Theme.of(context).primaryColor,
              child: ChatPrompterAnimation(
                size: Size(context.width, context.height * .9),
                lavaCount: 5,
                color: bgLight.withValues(alpha: 0.8),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: Align(
                alignment: Alignment.topRight,
                child: DayNightSwitch(
                  onChange: (_) {
                    toggleTheme(context);
                  },
                  duration: 600.milliseconds,
                  size: context.isMobile ? 20.sp : 25.sp,
                  initiallyDark: themeMode.value == ThemeMode.dark,
                ),
              ),
            ),
            Container(
              width: context.width,
              height: context.height * .9,
              padding: EdgeInsets.all(15.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(2, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animCtr,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: Transform.translate(
                      offset: Offset(80, 0),
                      child: Transform.rotate(
                        angle: -math.pi / 10,
                        child: Image.asset(
                          'assets/images/home.png',
                          height: context.height * 0.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Gap(40.sp),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.sp),
                      child: Container(
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Direct Message',
                              style: TextStyle(
                                fontSize: 70.sp,
                                color: bgDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Message Anyone. Instantly. No Contacts Needed.',
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: bgDark,
                              ),
                            ),
                            Gap(40.sp),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final url = Uri.parse(
                                          'https://play.google.com/store/apps/details?id=dev.yashashm.directmessage');
                                      if (await canLaunchUrl(url)) {
                                        launchUrl(url);
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/google.svg',
                                      width: context.width / 6,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(-2, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animCtr,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: Transform.translate(
                      offset: Offset(-80, 0),
                      child: Transform.rotate(
                        angle: math.pi / 10,
                        child: Image.asset(
                          'assets/images/code.png',
                          height: context.height * 0.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(30.sp),
        Text(
          'Why Direct Message?',
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(30.sp),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.sp,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 30.sp,
            children: children(),
          ),
        ),
        Gap(30.sp),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Download Now',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(30.sp),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                          'https://play.google.com/store/apps/details?id=dev.yashashm.directmessage');
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/images/google.svg',
                      width: context.width / 6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Coming Soon!',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(30.sp),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      // final url = Uri.parse(
                      //     'https://play.google.com/store/apps/details?id=dev.yashashm.directmessage');
                      // if (await canLaunchUrl(url)) {
                      //   launchUrl(url);
                      // }
                    },
                    child: SvgPicture.asset(
                      'assets/images/apple.svg',
                      width: context.width / 6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(30.sp),
        Container(
          width: context.width,
          color: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.all(15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width,
              ),
              Gap(10.sp),
              Text(
                'Not affiliated with WhatsApp by Meta',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiary
                      .withValues(alpha: 0.5),
                ),
              ),
              Gap(10.sp),
              Text(
                'Built with ❤️ by Yashas H Majmudar',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> children() {
    final list = <Widget>[];

    final headlines = [
      'User-Friendly',
      'Instant Messaging',
      'Privacy First',
      'Lightweight & Fast',
    ];
    final texts = [
      'Simple, intuitive design that saves you time and effort.',
      'Send WhatsApp messages quickly without saving contacts.',
      'Keep your contact list clean and your information private.',
      'A small app that\'s big on speed and simplicity.',
    ];

    for (var index = 0; index < headlines.length; index++) {
      list.add(
        Expanded(
          child: Container(
            height: context.height / 6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            padding: EdgeInsets.all(15.sp),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  headlines[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                Gap(15.sp),
                Text(
                  texts[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return list;
  }
}
