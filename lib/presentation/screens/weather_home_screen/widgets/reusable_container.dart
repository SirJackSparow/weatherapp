

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:weatherapps/const/app_color.dart';
import 'package:weatherapps/const/app_extentions.dart';
import 'package:weatherapps/const/appresources.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/const/utils/weather_font_sizes.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';

import '../../../../const/utils/weather_app_fonts.dart';
import '../../../controllers/settings_farenheit_controller/setting_farenheit_bloc.dart';

class NextWeekCard extends StatelessWidget {
  final String daysOfWeek;
  final ListElement forecastModel;
  final bool offline;

  const NextWeekCard(
      {Key? key, required this.daysOfWeek, required this.forecastModel, required this.offline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            daysOfWeek,
            style: WeatherAppFonts.medium()
                .copyWith(
                    color: WeatherAppColor.whiteColor,
                    fontWeight: FontWeight.w400)
                .copyWith(fontSize: WeatherAppFontSize.s14),
          ),
          Text(
            forecastModel.weather[0].description!,
            style: WeatherAppFonts.small()
                .copyWith(
                    color: WeatherAppColor.whiteColor,
                    fontWeight: FontWeight.w300)
                .copyWith(fontSize: WeatherAppFontSize.s14),
          ),
          SizedBox(
            height: 5.h,
          ),
      
          offline ? const Icon(Icons.cloud_off,size: 60.0,color: Colors.yellow) : Image.network(
              WeatherHome.getWeatherIconURL(forecastModel.weather[0].icon!),
              color: WeatherAppColor.yellowColor,
            ),
      
          /// temp
          BlocBuilder<SettingFarenheitBloc,
              SettingsFarenheitState>(
              builder: (context, state) {
                return setCelcius(state);
              }),
          SizedBox(
            height: 5.h,
          ),
      
          // wind speed
          Row(
            children: [
              Text(
                forecastModel.wind!.speed!.ceil().toString(),
                style: WeatherAppFonts.large()
                    .copyWith(
                        color: WeatherAppColor.whiteColor,
                        fontWeight: FontWeight.w400)
                    .copyWith(fontSize: WeatherAppFontSize.s10),
              ),
              3.0.sizeWidth,
              Image(
                image: Svg(WeatherAppResources.windIcon),
                width: 10,
                height: 10,
              )
            ],
          ),
      
          Text(
            WeatherAppString.kmh,
            style: WeatherAppFonts.large()
                .copyWith(
                    color: WeatherAppColor.whiteColor,
                    fontWeight: FontWeight.w400)
                .copyWith(fontSize: WeatherAppFontSize.s10),
          ),
        ],
      ),
    );
  }

  Widget setCelcius(state) {
    if (state is SetSettingFarenheit) {
      if (state.farenheit) {
        return Text(
          "${(forecastModel.main!.temp! / 10).ceil()} ${WeatherAppString.farenheit}",
          style: WeatherAppFonts.large()
              .copyWith(
              color: WeatherAppColor.whiteColor,
              fontWeight: FontWeight.w400)
              .copyWith(fontSize: WeatherAppFontSize.s16),
        );
      } else {
        return Text(
          "${(forecastModel.main!.temp! / 10).ceil()} ${WeatherAppString.celcius}",
          style: WeatherAppFonts.large()
              .copyWith(
              color: WeatherAppColor.whiteColor,
              fontWeight: FontWeight.w400)
              .copyWith(fontSize: WeatherAppFontSize.s16),
        );
      }
    } else {
      return Text(
        "${(forecastModel.main!.temp! / 10).ceil()} ${WeatherAppString.celcius}",
        style: WeatherAppFonts.large()
            .copyWith(
            color: WeatherAppColor.whiteColor,
            fontWeight: FontWeight.w400)
            .copyWith(fontSize: WeatherAppFontSize.s16),
      );
    }
  }
}
