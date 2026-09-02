part of 'theme.dart';

/// Owns the app's theme mode (persisted) and exposes a toggle.
class ThemeController {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.system);

  bool get isDark => mode.value == ThemeMode.dark;

  /// Restores the saved preference, or falls back to the system brightness.
  Future<void> init(BuildContext context) async {
    final saved = await Preferences.getDarkMode;
    if (saved != null) {
      mode.value = saved ? ThemeMode.dark : ThemeMode.light;
      return;
    }
    if (context.mounted) {
      final dark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
      mode.value = dark ? ThemeMode.dark : ThemeMode.light;
      Preferences.setDarkMode(dark);
    }
  }

  Future<void> toggle() async {
    final dark = !isDark;
    mode.value = dark ? ThemeMode.dark : ThemeMode.light;
    Preferences.setDarkMode(dark);
  }
}
