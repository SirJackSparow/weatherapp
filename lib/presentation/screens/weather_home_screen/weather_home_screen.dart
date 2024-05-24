import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapps/const/utils/utils.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/data/shared_pref/sharedprefs_service.dart';
import 'package:weatherapps/presentation/controllers/conectivity/internate_connectivity_bloc.dart';
import 'package:weatherapps/presentation/controllers/get_local_controller/get_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/settings_theme_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_util.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/widgets/weather_offline_widget.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/widgets/weather_online_widget.dart';

import '../../../const/app_color.dart';
import '../../../const/utils/weather_app_fonts.dart';
import '../../../const/utils/weather_font_sizes.dart';
import '../../controllers/settings_farenheit_controller/setting_farenheit_bloc.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final GlobalKey<State> permissionDialogKey = GlobalKey<State>();
  bool isLocationServiceInitialized = false;
  bool theme = false;
  bool s = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initLocationService();
    setTheme(context, null);
    setFarenheit(context,null);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawerWeather(),
        body:
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
                    WeatherHomeUtils.saveCity(weatherCityModel, context);
                    return WeatherUIWidget(
                      weatherModel: weatherCityModel,
                    );
                  }
                  return Container();
                },
                listener:
                    (BuildContext context, WeatherHomeControllerState state) {
                  if (state is CurrentCityWeatherInfoLoadingError) {
                    log(state.errorMessage);
                  }
                },
              );
            } else if (state is NotConnectedState) {
              HomeUtils.getLocalData(context);
              HomeUtils.getForeCastData(context);
              return BlocBuilder<GetLocalDataBloc, GetLocalDataState>(
                builder: (context, states) {
                  if (states is GetLocalDataLoaded) {
                    return WeatherOfflineWidget(
                        weatherModel: states.weatherModel);
                  } else if (states is GetLocalDataWeatherError) {
                    log(states.errorMessage);
                  }
                  return Container();
                },
              );
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

  Widget drawerWeather() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              WeatherAppString.drawerHeader,
              style: WeatherAppFonts.large(
                      fontWeight: FontWeight.w700,
                      color: WeatherAppColor.blackColor)
                  .copyWith(fontSize: WeatherAppFontSize.s17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              Text(
                WeatherAppString.darkTheme,
                style: WeatherAppFonts.medium(
                        fontWeight: FontWeight.w400,
                        color: WeatherAppColor.blackColor)
                    .copyWith(fontSize: WeatherAppFontSize.s14),
              ),
              Expanded(child: Container()),
              Switch(
                  value: theme,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      theme = value;
                      setTheme(context, theme);
                    });
                  })
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              Text(
                WeatherAppString.farenheitName,
                style: WeatherAppFonts.medium(
                        fontWeight: FontWeight.w400,
                        color: WeatherAppColor.blackColor)
                    .copyWith(fontSize: WeatherAppFontSize.s14),
              ),
              Expanded(child: Container()),
              Switch(
                  value: s,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    setState(() {
                      s = value;
                      setFarenheit(context, s);
                    });
                  })
            ]),
          ),
        ],
      ),
    );
  }

  void setTheme(BuildContext context, bool? value) async {
    theme =
        value ?? await SharedprefsService.getData(WeatherAppString.isDarkTheme);
    await SharedprefsService.isDarkTheme(theme);
    final blocTheme = BlocProvider.of<SettingsThemeBloc>(context);
    blocTheme.add(SetSettingsThemeEvent(theme));
  }

  void setFarenheit(BuildContext context,bool? value) async {
    s = value ?? await SharedprefsService.getData(WeatherAppString.isFarenheit);
    await SharedprefsService.isFarenHeit(s);
    final blocFarenHeit = BlocProvider.of<SettingFarenheitBloc>(context);
    blocFarenHeit.add(SetSettingsFarenheitEvent(s));
  }
}
