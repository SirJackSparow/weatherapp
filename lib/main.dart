import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapps/const/applocator/service_locator.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/presentation/controllers/conectivity/internate_connectivity_bloc.dart';
import 'package:weatherapps/presentation/controllers/favorite_controller/favorite_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_controller/forecast_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_get_local_controller/get_forecast_local_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_local_controller/save_forecast_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/get_local_controller/get_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/localdatabase_controller/save_data_local_bloc.dart';
import 'package:weatherapps/presentation/controllers/settings_farenheit_controller/setting_farenheit_bloc.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/settings_theme_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_controller_bloc.dart';
import 'package:weatherapps/presentation/screens/theme/Themes.dart';
import 'package:weatherapps/routes/weather_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    WeatherHomeControllerBloc(appServiceLocator()),
              ),
              BlocProvider(
                  create: (context) =>
                      ForecastControllerBloc(appServiceLocator())),
              BlocProvider(create: (context) => InternateConnectivityBloc()),

              BlocProvider(create: (context) => SaveDataLocalBloc(appServiceLocator())),
              
              BlocProvider(create: (context) => GetLocalDataBloc(appServiceLocator())),

              BlocProvider(create: (context) => GetForeCastBloc(appServiceLocator())),

              BlocProvider(create: (context) => SaveForeCastBloc(appServiceLocator())),

              BlocProvider(create: (context) => FavoriteBloc(appServiceLocator())),

              BlocProvider(create: (context) => SettingsThemeBloc(appServiceLocator())),

              BlocProvider(create: (context) => SettingFarenheitBloc(appServiceLocator()))
            ],
            child: BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  theme: Themes.theme,
                  debugShowCheckedModeBanner: false,
                  darkTheme: Themes.darkTheme,
                  title: WeatherAppString.title,
                  themeMode:setThemes(state),
                  onGenerateRoute: RouteGenerator.getRoute,
                  initialRoute: WeatherRoutes.homePageRoute,
                );
              }
            ),
          );
        });
  }

  ThemeMode setThemes(state){
    if(state is SetSettingTheme) {
      return state.themes ?
       ThemeMode.dark :  ThemeMode.light;
    }
    return ThemeMode.light;
  }
}
