import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/const/appresources.dart';
import 'package:weatherapps/presentation/commonwidgets/weather_app_bar.dart';

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
          child: WeatherAppBar(cityNames: weatherModel.name, onTap: () {}))
    ]);
  }
}
