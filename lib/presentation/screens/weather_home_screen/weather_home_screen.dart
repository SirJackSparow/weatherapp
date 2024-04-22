import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapps/const/utils/utils.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/presentation/controllers/conectivity/internate_connectivity_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_controller_bloc.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/widgets/weather_widget.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final GlobalKey<State> permissionDialogKey = GlobalKey<State>();
  bool isLocationServiceInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initLocationService();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<InternateConnectivityBloc, InternateConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return BlocConsumer<WeatherHomeControllerBloc,
              WeatherHomeControllerState>(
            buildWhen: (previous, current) {
              return (previous is CurrentCityWeatherInfoLoading &&
                      current is CurrentCityDataLoaded) ||
                  (current is CurrentCityDataLoaded &&
                      previous is CurrentCityDataLoaded);
            },
            listenWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              if (state is CurrentCityDataLoaded) {
                WeatherModel weatherCityModel = state.currentCityData;
                weatherCityModel.isCurrentCity = true;
                return WeatherUIWidget(
                  weatherModel: weatherCityModel,
                );
              }
              return Container();
            },
            listener: (BuildContext context, WeatherHomeControllerState state) {
              if (state is CurrentCityWeatherInfoLoadingError) {
                log(state.errorMessage);
              }
            },
          );
        } else if (state is NotConnectedState) {
          log("Not connected");
        }
        return Container();
      },
    ));
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (!isLocationServiceInitialized) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.denied) {
          await initLocationService();
          isLocationServiceInitialized = true;
        } else {
          await initLocationService();
        }
      }
    }
  }

  Future<void> initLocationService() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      if (mounted) {
        await HomeUtils.showLocationServiceDialog(context, mounted);
      }
    } else {
      dismissPermissionDialog();
      await handleLocationPermission();
    }
  }

  Future<void> handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            HomeUtils.permissionDialog(
                context, permissionDialogKey, mounted, false, false);
          }
          return;
        } else if (permission == LocationPermission.deniedForever) {
          if (mounted) {
            await openAppSettings();
          }
          return;
        }
        break;
      case LocationPermission.deniedForever:
        if (mounted) {
          await openAppSettings();
        }
        return;
      default:
        break;
    }
    if (mounted) {
      isLocationServiceInitialized = true;
      await HomeUtils.getPosition(
          context, mounted, permissionDialogKey, false, false);
    }
  }

  void dismissPermissionDialog() {
    if (permissionDialogKey.currentState != null &&
        permissionDialogKey.currentContext != null) {
      Navigator.of(permissionDialogKey.currentContext!).pop();
    }
  }
}
