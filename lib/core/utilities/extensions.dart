import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  bool get isMobile => height > width;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  Size get screenSize => MediaQuery.of(this).size;

  bool get isSystemDark =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}

extension NumberExtensions on num {
  Duration get milliseconds => Duration(milliseconds: round());
}
