import 'package:either_dart/either.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';

class WeatherAppUseCases {
  final BaseRemoteRepository baseWeatherRepository;

  WeatherAppUseCases(this.baseWeatherRepository);

  Future<Either<String, WeatherModel>> getCurrentCityWeather(
      String cityName) async {
    return await baseWeatherRepository.getWeatherForCurrentCity(cityName);
  }

  Future<Either<String, WeatherModel>> saveLocalDatabase(WeatherModel weatherModel) async {
   return await baseWeatherRepository.saveWeatherLocalData(weatherModel);
  }


}
