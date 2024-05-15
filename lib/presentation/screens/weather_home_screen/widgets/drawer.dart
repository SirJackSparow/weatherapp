import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../const/app_color.dart';
import '../../../../const/utils/weather_app_fonts.dart';
import '../../../../const/utils/weather_app_string.dart';
import '../../../../const/utils/weather_font_sizes.dart';

  Widget drawerWeather() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child:  Text(
              WeatherAppString.drawerHeader,
              style: WeatherAppFonts.large(
                  fontWeight: FontWeight.w700,
                  color: WeatherAppColor.blackColor)
                  .copyWith(
                  fontSize: WeatherAppFontSize.s17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(

              children: [
                Text(
                  WeatherAppString.drawerHeader,
                  style: WeatherAppFonts.large(
                      fontWeight: FontWeight.w700,
                      color: WeatherAppColor.blackColor)
                      .copyWith(
                      fontSize: WeatherAppFontSize.s17),
                ),
                Expanded(child: Container()),
                Switch(value: true, onChanged: (bool value) {

              })]
            ),
          )
        ],
      ),
    );
  }

