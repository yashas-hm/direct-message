import 'dart:math' as math;

import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:lava_lamp_effect/lava_lamp_effect.dart';
import 'package:direct_message/core/constants/app_colors.dart';
import 'package:direct_message/core/constants/app_constants.dart';
import 'package:direct_message/core/utilities/extensions.dart';
import 'package:direct_message/core/utilities/utils.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: context.isMobile ? HomePortrait() : HomeLandscape(),
      ),
    );
  }
}

class HomePortrait extends StatefulWidget {
  const HomePortrait({super.key});

  @override
  State<HomePortrait> createState() => _HomePortraitState();
}

class _HomePortraitState extends State<HomePortrait>
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
      spacing: 15.sp,
      children: [
        Stack(
          children: [
            Container(
              width: context.width,
              height: context.height * .9,
              color: Theme.of(context).primaryColor,
              child: LavaLampEffect(
                size: Size(context.width, context.height * .9),
                lavaCount: 5,
                color: bgLight.withValues(alpha: 0.8),
              ),
            ),
            Container(
              width: context.width,
              height: context.height * .9,
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: context.width,
                    child: DayNightSwitch(
                      onChange: (_) {
                        toggleTheme(context);
                      },
                      duration: 600.milliseconds,
                      size: 20.sp,
                      initiallyDark: themeMode.value == ThemeMode.dark,
                    ),
                  ),
                  Gap(30.sp),
                  Stack(
                    children: [
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animCtr,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Transform.rotate(
                          angle: math.pi / 15,
                          child: Transform.translate(
                            offset: Offset(context.width / 6, context.width / 4),
                            child: Image.asset(
                              'assets/images/code.png',
                              width: context.width / 2.5,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(-1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animCtr,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Transform.rotate(
                          angle: -math.pi / 15,
                          child: Transform.translate(
                            offset: Offset(-context.width / 6, 0),
                            child: Image.asset(
                              'assets/images/home.png',
                              width: context.width / 2.5,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(context.width / 3),
                  Expanded(
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Direct Message',
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: bgDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\nMessage Anyone. Instantly. No Contacts Needed.',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: bgDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                          'https://play.google.com/store/apps/details?id=dev.yashashm.directmessage');
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      }
                    },
                    child: SvgPicture.asset(
                      'assets/images/google.svg',
                      width: context.width / 2.5,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'Why Direct Message?',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...children(context),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Download Now',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8.sp.sp),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://play.google.com/store/apps/details?id=dev.yashashm.directmessage');
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/images/google.svg',
                    width: context.width / 2.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Coming Soon!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8.sp.sp),
                GestureDetector(
                  onTap: () async {
                    // final url = Uri.parse(
                    //     'https://play.google.com/store/apps/details?id=dev.yashashm.directmessage');
                    // if (await canLaunchUrl(url)) {
                    //   launchUrl(url);
                    // }
                  },
                  child: SvgPicture.asset(
                    'assets/images/apple.svg',
                    width: context.width / 2.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: context.width,
          color: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.all(8.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5.sp,
            children: [
              Text(
                'Not affiliated with WhatsApp by Meta',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiary
                      .withValues(alpha: 0.5),
                ),
              ),
              Text(
                'Built with ❤️ by Yashas H Majmudar',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              )
            ],
          ),
        ),
      ],
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
      spacing: 30.sp,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: context.width,
              height: context.height * .9,
              color: Theme.of(context).primaryColor,
              child: LavaLampEffect(
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
        Text(
          'Why Direct Message?',
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.sp,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 30.sp,
            children: children(context),
          ),
        ),
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
        Container(
          width: context.width,
          color: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.all(15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10.sp,
            children: [
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
}

List<Widget> children(BuildContext context) {
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
    final container = Container(
      margin: EdgeInsets.symmetric(horizontal: context.isMobile ? 15.sp : 0.sp),
      height: context.height / 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      padding: EdgeInsets.all(context.isMobile ? 8.sp : 15.sp),
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
              fontSize: context.isMobile ? 18.sp : 22.sp,
            ),
          ),
          Gap(context.isMobile ? 8.sp : 15.sp),
          Text(
            texts[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.isMobile ? 14.sp : 18.sp,
            ),
          ),
        ],
      ),
    );
    if (context.isMobile) {
      list.add(
        container,
      );
    } else {
      list.add(
        Expanded(
          child: container,
        ),
      );
    }
  }

  return list;
}
