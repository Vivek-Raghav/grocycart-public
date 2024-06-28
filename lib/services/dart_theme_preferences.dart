import 'package:shared_preferences/shared_preferences.dart';

// final SharedPreferences prefs = await SharedPreferences.getInstance();

class DarkThemePrefs {
  static const currentThemeStatus = "theme_status";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(currentThemeStatus, value);
  }

  Future<bool> getThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(currentThemeStatus) ?? false;
  }
}
