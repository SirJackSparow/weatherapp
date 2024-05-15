import 'package:flutter/material.dart';
import 'package:weatherapps/const/app_color.dart';
import 'package:weatherapps/const/utils/weather_app_fonts.dart';
import 'package:weatherapps/const/utils/weather_font_sizes.dart';

class WeatherAppBar extends StatelessWidget {
  final String cityNames;
  final Function onTap;

  const WeatherAppBar({
    super.key,
    required this.cityNames,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: WeatherAppColor.transParentColor,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu, color: WeatherAppColor.whiteColor),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(
        cityNames,
        style: WeatherAppFonts.medium(
                fontWeight: FontWeight.w400, color: WeatherAppColor.whiteColor)
            .copyWith(fontSize: WeatherAppFontSize.s18),
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: GestureDetector(
              onTap: () {
                onTap.call();
              },
              child: Icon(Icons.search, color: WeatherAppColor.whiteColor)),
        )
      ], // Removes shadow
    );
  }
}
