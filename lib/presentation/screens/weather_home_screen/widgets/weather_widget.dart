import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapps/const/app_color.dart';
import 'package:weatherapps/const/app_extentions.dart';
import 'package:weatherapps/const/utils/utils.dart';
import 'package:weatherapps/const/utils/weather_app_fonts.dart';
import 'package:weatherapps/const/utils/weather_font_sizes.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/const/appresources.dart';
import 'package:weatherapps/presentation/commonwidgets/weather_app_bar.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class WeatherUIWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherUIWidget({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    log(weatherModel.cityImageURL.toString());
    return Stack(children: [
      weatherModel.cityImageURL!.isEmpty
          ? Positioned.fill(
              child: Image.asset(
              WeatherAppResources.cityPlaceHolder,
              fit: BoxFit.cover,
            ))
          : Positioned.fill(
              child: FadeInImage(
              placeholder: AssetImage(WeatherAppResources.cityPlaceHolder),
              image: NetworkImage(weatherModel.cityImageURL!),
              fit: BoxFit.cover,
            )),
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: WeatherAppBar(cityNames: weatherModel.name, onTap: () {})),
      Padding(
        padding: EdgeInsets.only(top: 70.h),
        child: ListView(
          children: [
            SizedBox(height: AppBar().preferredSize.height),
            20.0.sizeHeight,

            //today
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GlassContainer(
                color: WeatherAppColor.blackColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      HomeUtils.getFormattedDate(),
                      style: WeatherAppFonts.large(
                              fontWeight: FontWeight.w300,
                              color: WeatherAppColor.whiteColor)
                          .copyWith(fontSize: WeatherAppFontSize.s30),
                    )),
                    2.0.sizeHeight,

                    /// updated at
                    2.0.sizeHeight,
                    Center(
                        child: Text(
                      HomeUtils.formatDateTime(
                          weatherModel.updatedAt.toIso8601String()),
                      style: WeatherAppFonts.large(
                              fontWeight: FontWeight.w300,
                              color:
                                  WeatherAppColor.whiteColor.withOpacity(0.75))
                          .copyWith(
                        fontSize: WeatherAppFontSize.s16,
                      ),
                    )),

                    /// display data from API
                    Column(
                      children: [
                        10.0.sizeHeight,
                        HomeUtils.getWeatherIcon(
                                    weatherModel.weather[0].icon) !=
                                WeatherIcons.refresh
                            ? Icon(
                                HomeUtils.getWeatherIcon(
                                    weatherModel.weather[0].icon),
                                size: 100.0,
                                color: WeatherAppColor.yellowColor,
                              )
                            : Image.network(
                                HomeUtils.getWeatherIconURL(
                                    weatherModel.weather[0].icon),
                                color: WeatherAppColor.yellowColor,
                              ),
                        10.0.sizeHeight,
                        Text(
                          weatherModel.weather[0].description
                              .capitalizeFirstLater(),
                          style: WeatherAppFonts.large(
                                  fontWeight: FontWeight.w700,
                                  color: WeatherAppColor.whiteColor)
                              .copyWith(fontSize: WeatherAppFontSize.s30),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(children: <InlineSpan>[
                              TextSpan(
                                text:
                                    (weatherModel.main.temp.ceil()).toString(),
                                style: WeatherAppFonts.large(
                                        fontWeight: FontWeight.w500,
                                        color: WeatherAppColor.whiteColor)
                                    .copyWith(fontSize: WeatherAppFontSize.s48),
                              ),
                              WidgetSpan(
                                  child: Transform.translate(
                                      offset: const Offset(2, -8),
                                      child: Text(
                                        "ºC",
                                        style: WeatherAppFonts.large(
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    WeatherAppColor.whiteColor)
                                            .copyWith(
                                                fontSize:
                                                    WeatherAppFontSize.s24),
                                      )))
                            ]))
                          ],
                        ),

                        /// humidty... feels like
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image(
                                      image:
                                          Svg(WeatherAppResources.humidtyIcon)),
                                  3.0.sizeHeight,
                                  Text(
                                    "Humidity",
                                    style: WeatherAppFonts.large(
                                            fontWeight: FontWeight.w500,
                                            color: WeatherAppColor.whiteColor)
                                        .copyWith(
                                            fontSize: WeatherAppFontSize.s14),
                                  ),
                                  3.0.sizeHeight,
                                  Text(
                                    "${weatherModel.main.humidity} %",
                                    style: WeatherAppFonts.large(
                                            fontWeight: FontWeight.w500,
                                            color: WeatherAppColor.whiteColor)
                                        .copyWith(
                                            fontSize: WeatherAppFontSize.s14),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Image(
                                      image: Svg(WeatherAppResources.windIcon)),
                                  3.0.sizeHeight,
                                  Text(
                                    "Wind",
                                    style: WeatherAppFonts.large(
                                            fontWeight: FontWeight.w500,
                                            color: WeatherAppColor.whiteColor)
                                        .copyWith(
                                            fontSize: WeatherAppFontSize.s14),
                                  ),
                                  3.0.sizeHeight,
                                  Text(
                                    "${weatherModel.wind.speed} km/h",
                                    style: WeatherAppFonts.large(
                                            fontWeight: FontWeight.w500,
                                            color: WeatherAppColor.whiteColor)
                                        .copyWith(
                                            fontSize: WeatherAppFontSize.s14),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image(
                                      image:
                                          Svg(WeatherAppResources.feelsLike)),
                                  3.0.sizeHeight,
                                  Text(
                                    "Feels Like",
                                    style: WeatherAppFonts.large(
                                            fontWeight: FontWeight.w500,
                                            color: WeatherAppColor.whiteColor)
                                        .copyWith(
                                            fontSize: WeatherAppFontSize.s14),
                                  ),
                                  3.0.sizeHeight,
                                  Text(
                                    weatherModel.main.feelsLike
                                        .ceil()
                                        .toString(),
                                    style: WeatherAppFonts.large(
                                            fontWeight: FontWeight.w500,
                                            color: WeatherAppColor.whiteColor)
                                        .copyWith(
                                            fontSize: WeatherAppFontSize.s14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
