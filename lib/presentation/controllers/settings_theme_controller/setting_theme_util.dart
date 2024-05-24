import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/settings_theme_bloc.dart';

class SettingThemeUtil {
  static Widget backGround(state) {
    if(state is SetSettingTheme){
      if(state.themes){
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset('assets/json/dark_mode.json', fit: BoxFit.cover),
        );
      } else {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset('assets/json/morning_mode.json', fit: BoxFit.cover),
        );
      }
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Lottie.asset('assets/json/morning_mode.json', fit: BoxFit.cover),
    );
  }
}