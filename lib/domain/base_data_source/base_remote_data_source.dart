import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';

abstract class BaseRemoteDataSource {
  Future<Either<String, WeatherModel>> getWeatherInfoForCurrentCity(
      String cityName);

  Future<Either<String, ForeCastModel>> getForecast(String cityName);

  Future<Either<String, WeatherModel>> saveWeatherLocalData(WeatherModel weatherModel);

  Future<Either<String,WeatherModel>> getWeatherFromLocal();

  Future<Either<String,ForeCastModel>> saveForeCast(ForeCastModel foreCastModel);

  Future<Either<String, ForeCastModel>> getForecastLocalData();

  Future<Either<String,WeatherModel>> saveFavorite(WeatherModel weatherModel);

  Future<Either<String, List<WeatherModel>>> getFavorite();

  Future<Either<String,WeatherModel>> deleteFavorite();

  Future<Either<String, bool>> getTheme();

  Future<Either<String, bool>> setTheme(bool theme);

  Future<Either<String, bool>> getFarenheit();

  Future<Either<String, bool>> setFarenheit(bool farenheit);
}
