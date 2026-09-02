import 'package:direct_message/theme/theme.dart' show DmColors;
import 'package:flutter/material.dart' show Theme;
import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  bool get isMobile => height > width;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  Size get screenSize => MediaQuery.of(this).size;

  bool get isSystemDark =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  /// Theme-aware colours registered via the [DmColors] theme extension.
  DmColors get colors => Theme.of(this).extension<DmColors>()!;
}