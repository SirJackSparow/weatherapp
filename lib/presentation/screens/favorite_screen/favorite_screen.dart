import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/presentation/controllers/favorite_controller/favorite_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/setting_theme_util.dart';

import '../../../const/utils/weather_app_string.dart';
import '../../../data/entity/weather_entity.dart';
import '../../controllers/forecast_controller/forecast_controller_bloc.dart';
import '../../controllers/settings_theme_controller/settings_theme_bloc.dart';
import '../../controllers/weather_home_controller/weather_home_controller_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _getFavorite(context);
    return BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
      builder: (context,state) {
        bool isDarkTheme = false;
        if(state is SetSettingTheme){
          isDarkTheme = state.themes;
        }
        return Scaffold(
          backgroundColor: isDarkTheme ? Colors.black : Colors.white,
          appBar: AppBar(title: Text(WeatherAppString.favourite),),
          body: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
               if(state is FavoriteDataLoaded) {
                 if(state.weatherModel.isEmpty) {
                   return const Center(child: Text("Data is Empty"),);
                 }
                return ListView.builder(
                    itemCount: state.weatherModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(state.weatherModel[index].name, style: TextStyle(
                          color: isDarkTheme ? Colors.white : Colors.black
                        ),),
                        subtitle: Text(state.weatherModel[index].weather[0].description, style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black
                        ),),
                        leading: IconButton(icon: const Icon(Icons.remove_circle_outline), color: Colors.red, onPressed: () {
                          _deleteFavorite(state.weatherModel[index], context);
                        },),
                        onTap: () {
                          _onClickCity(state.weatherModel[index].name,context);
                          Navigator.pop(context);
                        },
                      );
                    });
              }
             return const Center(child: Text("Error"),);
            },
          ),
        );
      }
    );
  }

  void _onClickCity(String cityName, BuildContext context) async {
    final weatherCityBloc = BlocProvider.of<WeatherHomeControllerBloc>(context);
    weatherCityBloc.add(GetCurrentCityWeatherInfo(cityName));
    await _forecast(cityName, context);
  }

  _forecast(String cityName, BuildContext context) {
    final foreCastBloc = BlocProvider.of<ForecastControllerBloc>(context);
    foreCastBloc.add(GetForecast(cityName));
  }

  void _getFavorite(BuildContext context) async {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(const GetFavoriteEvent());
  }
  void _deleteFavorite(WeatherModel weatherModel, BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(FavoriteSaveEvent(weatherModel));
  }
}
