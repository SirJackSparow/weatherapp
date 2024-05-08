import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';

abstract class BaseRemoteRepository {
  Future<Either<String, WeatherModel>> getWeatherForCurrentCity(
      String cityName);
  Future<Either<String, ForeCastModel>> getForecast(String cityName);

  Future<Either<String, WeatherModel>> saveWeatherLocalData(WeatherModel weatherModel);

  Future<Either<String, WeatherModel>> getWeatherLocalData();

  Future<Either<String, ForeCastModel>> saveForeCastData(ForeCastModel foreCastModel);

  Future<Either<String, ForeCastModel>> getForeCastData();

  Future<Either<String, List<WeatherModel>>> getFavorite();

  Future<Either<String, WeatherModel>> saveFavorite(WeatherModel weatherModel);
}
