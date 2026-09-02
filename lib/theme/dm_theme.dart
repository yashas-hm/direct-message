part of 'theme.dart';

/// Builds the app [ThemeData] for light and dark, wiring in [DmColors].
class DmTheme {
  DmTheme(this.context);

  final BuildContext context;

  static final LightColors _light = LightColors();
  static final DarkColors _dark = DarkColors();

  ThemeData get light => _build(Brightness.light, _light);

  ThemeData get dark => _build(Brightness.dark, _dark);

  ThemeData _build(Brightness brightness, DmColors colors) {
    final isLight = brightness == Brightness.light;
    return ThemeData(
      useMaterial3: false,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme.apply(
          bodyColor: colors.text,
          displayColor: colors.text,
        ),
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: brightness,
          statusBarColor: colors.surface,
          statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        ),
        elevation: 5,
        iconTheme: IconThemeData(color: colors.text),
        backgroundColor: colors.surface,
        titleTextStyle: (isLight ? GoogleFonts.roboto : GoogleFonts.pacifico)(
          fontSize: 30,
          color: colors.text,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        primary: colors.primary,
        secondary: colors.surface,
        tertiary: colors.text,
        brightness: brightness,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: colors.primary,
        cursorColor: colors.text,
        selectionColor: colors.primary.withValues(alpha: 0.3),
      ),
      extensions: [colors],
    );
  }
}
