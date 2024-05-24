import 'package:shared_preferences/shared_preferences.dart';

import '../../const/utils/weather_app_string.dart';

class SharedprefsService {
  static SharedPreferences? _preferences;

  static Future<bool> isDarkTheme(bool value) async{
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!.setBool(WeatherAppString.isDarkTheme, value);
  }

  static Future<bool> isFarenHeit(bool value) async{
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!.setBool(WeatherAppString.isFarenheit, value);
  }

  static Future<bool> getData (String key) async{
    _preferences ??= await SharedPreferences.getInstance();
    var value = _preferences!.getBool(key);
    return value ?? false;
  }
}
