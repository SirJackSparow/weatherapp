import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherapps/const/applocator/service_locator.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/presentation/controllers/conectivity/internate_connectivity_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_controller/forecast_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_get_local_controller/get_forecast_local_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_local_controller/save_forecast_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/get_local_controller/get_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/localdatabase_controller/save_data_local_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_controller_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapps/routes/weather_routes.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kColorDarkScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: const Color.fromARGB(255, 22, 151, 221),
  colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer,
      centerTitle: true),
  cardTheme: const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer)),
  textTheme: GoogleFonts.latoTextTheme(),
);

final darkTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: const Color.fromARGB(255, 43, 42, 42),
  colorScheme: kColorDarkScheme,
  cardTheme: const CardTheme().copyWith(
    color: kColorDarkScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: kColorDarkScheme.primaryContainer,
    foregroundColor: kColorDarkScheme.onPrimaryContainer,
  )),
);

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

              BlocProvider(create: (context) => SaveForeCastBloc(appServiceLocator()))
            ],
            child: MaterialApp(
              theme: theme,
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme,
              title: WeatherAppString.title,
              themeMode: ThemeMode.system,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: WeatherRoutes.homePageRoute,
            ),
          );
        });
  }
}
