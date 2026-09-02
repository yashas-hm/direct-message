import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:direct_message/theme/sizes.dart';
import 'package:direct_message/theme/theme.dart';
import 'package:direct_message/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const String _privacyUrl = 'https://directmessage.yashashm.dev/privacy-policy';

/// Side drawer: theme toggle on top, privacy policy and version at the bottom.
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _version = info.version);
  }

  Future<void> _openPrivacy() async {
    final uri = Uri.parse(_privacyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Drawer(
      backgroundColor: colors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Scaffold.of(context).closeEndDrawer(),
                  icon: Icon(Icons.close, color: colors.text, size: Sizes.iconMd),
                  tooltip: 'Close',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const Gap(Sizes.spacingLg),
              Row(
                children: [
                  Icon(
                    Icons.brightness_6_outlined,
                    color: colors.text,
                    size: Sizes.iconMd,
                  ),
                  const Gap(Sizes.spacingMd),
                  Text(
                    'Theme',
                    style: TextStyle(
                      fontSize: Sizes.fontMd,
                      fontWeight: FontWeight.w600,
                      color: colors.text,
                    ),
                  ),
                  const Spacer(),
                  DayNightSwitch(
                    onChange: (_) => ThemeController.instance.toggle(),
                    duration: Durations.long1,
                    size: Sizes.iconLg,
                    initiallyDark: ThemeController.instance.isDark,
                  ),
                ],
              ),
              const Spacer(),
              if (_version.isNotEmpty)
                Center(
                  child: Text(
                    'Version $_version',
                    style: TextStyle(
                      fontSize: Sizes.fontMd,
                      color: colors.text.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              Center(
                child: InkWell(
                  onTap: _openPrivacy,
                  borderRadius: BorderRadius.circular(Sizes.radiusSm),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.spacingSm,
                      vertical: Sizes.spacingXs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: Sizes.fontSm,
                            color: colors.text.withValues(alpha: 0.5),
                          ),
                        ),
                        const Gap(Sizes.spacingXs),
                        Icon(
                          Icons.open_in_new,
                          size: Sizes.fontSm,
                          color: colors.text.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
