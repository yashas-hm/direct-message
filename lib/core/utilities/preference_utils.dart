import 'package:direct_message/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool?> get isDarkModePref async {
  final instance = await SharedPreferences.getInstance();
  return instance.getBool(darkModePrefTag);
}

void setIsDarkModePref(bool dark) async {
  final instance = await SharedPreferences.getInstance();
  await instance.setBool(darkModePrefTag, dark);
}

Future<String?> get getCountryCode async {
  final instance = await SharedPreferences.getInstance();
  return instance.getString(countryCodePrefTag);
}

void setCountryCode(String code) async {
  final instance = await SharedPreferences.getInstance();
  await instance.setString(countryCodePrefTag, code);
}
