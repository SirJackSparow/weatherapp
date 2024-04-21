import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';

abstract class BaseRemoteRepository {
  Future<Either<String, WeatherModel>> getWeatherForCurrentCity(
      String cityName);
}
