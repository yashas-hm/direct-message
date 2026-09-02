import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();

  static const String _darkModeTag = 'darkMode';
  static const String _countryCodeTag = 'countryCode';

  static Future<bool?> get getDarkMode async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool(_darkModeTag);
  }

  static Future<void> setDarkMode(bool dark) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool(_darkModeTag, dark);
  }

  static Future<String?> get getCountryCode async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString(_countryCodeTag);
  }

  static Future<void> setCountryCode(String code) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString(_countryCodeTag, code);
  }
}
