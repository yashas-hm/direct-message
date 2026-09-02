part of 'theme.dart';

/// Theme-aware colours, accessed in widgets via `context.colors`.
abstract class DmColors extends ThemeExtension<DmColors> {
  Color get primary;

  Color get onPrimary;

  Color get background;

  Color get surface;

  Color get text;

  @override
  DmColors lerp(DmColors? other, double t) {
    if (other == null) return this;
    return _LerpedDmColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
    );
  }

  @override
  DmColors copyWith() => this;
}

class LightColors extends DmColors {
  @override
  Color get primary => Palette.blueLight;

  @override
  Color get onPrimary => Palette.bgLight;

  @override
  Color get background => Palette.bgLight;

  @override
  Color get surface => Palette.lightElement;

  @override
  Color get text => Palette.bgDark;

  @override
  DmColors copyWith() => LightColors();
}

class DarkColors extends DmColors {
  @override
  Color get primary => Palette.blueDark;

  @override
  Color get onPrimary => Palette.bgLight;

  @override
  Color get background => Palette.bgDark;

  @override
  Color get surface => Palette.darkElement;

  @override
  Color get text => Palette.bgLight;

  @override
  DmColors copyWith() => DarkColors();
}

/// Interpolated colours used during theme transitions.
class _LerpedDmColors extends DmColors {
  _LerpedDmColors({
    required this.primary,
    required this.onPrimary,
    required this.background,
    required this.surface,
    required this.text,
  });

  @override
  final Color primary;

  @override
  final Color onPrimary;

  @override
  final Color background;

  @override
  final Color surface;

  @override
  final Color text;

  @override
  DmColors copyWith() => this;
}
