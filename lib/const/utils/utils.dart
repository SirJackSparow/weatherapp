import 'dart:io';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapps/data/network/services.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_controller_bloc.dart';
import 'package:intl/intl.dart';

class HomeUtils {
  static Future<void> showLocationServiceDialog(
      BuildContext context, bool mounted) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Service Disabled'),
          content: const Text('Please Enable Location'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> getPosition(
      BuildContext context,
      bool mounted,
      GlobalKey<State<StatefulWidget>> permissionDialogKey,
      bool isGettingUserPosition,
      bool? showDataFromSavedCities) async {
    try {
      await getUserPosition(
          isGettingUserPosition, context, mounted, showDataFromSavedCities);
    } catch (e) {
      if (mounted) {
        permissionDialog(context, permissionDialogKey, mounted,
            isGettingUserPosition, showDataFromSavedCities);
      }
    }
  }

  static void permissionDialog(
      BuildContext context,
      GlobalKey<State<StatefulWidget>> permissionDialogKey,
      bool mounted,
      bool isGettingUserPosition,
      bool? showDataFromSavedCities) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          key: permissionDialogKey,
          title: const Text('Location Services Disabled'),
          content: const Text('Location Enable'),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();

                getPosition(context, mounted, permissionDialogKey,
                    isGettingUserPosition, showDataFromSavedCities);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okay'),
                  ),
                  GestureDetector(
                    onTap: () {
                      exit(0);
                    },
                    child: const Text('cancel'),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static String getFormattedDate() {
    DateTime now = DateTime.now();

    ///  months
    List<String> monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    String month = monthNames[now.month];
    String year = now.year.toString();

    return '$month $year';
  }

  static Future<void> getUserPosition(
      bool isGettingUserPosition,
      BuildContext context,
      bool isMounted,
      bool? showDataFromSavedCities) async {
    if (isGettingUserPosition) {
      return;
    }
    isGettingUserPosition = true;
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) return;

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> locationPlaceMark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = locationPlaceMark[0];

      if (isMounted) {
        if (showDataFromSavedCities == false) {
          final weatherCityBloc =
              BlocProvider.of<WeatherHomeControllerBloc>(context);
          weatherCityBloc.add(GetCurrentCityWeatherInfo(place.locality!));
        }
      }
    } finally {
      isGettingUserPosition = false;
    }
  }

  static searchCity(String cityName, BuildContext context) {
    final weatherCityBloc = BlocProvider.of<WeatherHomeControllerBloc>(context);
    weatherCityBloc.add(GetCurrentCityWeatherInfo(cityName));
  }

  static String formatDateTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDateTime = DateFormat('M/d/yyyy h:mm a').format(dateTime);
    return formattedDateTime;
  }

  static getWeatherIcon(String weatherCode) {
    switch (weatherCode) {
      case "01d":
        return WeatherIcons.day_sunny;
      case "02d":
        return WeatherIcons.day_cloudy;
      case "03d":
        return WeatherIcons.cloud;
      case "04d":
        return WeatherIcons.cloudy;
      case "09d":
        return WeatherIcons.showers;
      case "10d":
        return WeatherIcons.rain;
      case "11d":
        return WeatherIcons.thunderstorm;
      case "13d":
        return WeatherIcons.snow;
      default:
        return WeatherIcons.refresh; // A fallback icon in case of unknown code
    }
  }

  static String getWeatherIconURL(String weatherCode) {
    return WeatherAppServices.iconURL +
        weatherCode +
        WeatherAppServices.iconSize;
  }
}
