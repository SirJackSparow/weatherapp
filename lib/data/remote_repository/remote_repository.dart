import 'package:either_dart/either.dart';
import 'package:weatherapps/domain/base_data_source/base_remote_data_source.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';

class WeatherRepository implements BaseRemoteRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  WeatherRepository(this.baseRemoteDataSource);

  @override
  Future<Either<String, WeatherModel>> getWeatherForCurrentCity(
      String cityName) async {
    final currentCityWeatherResult =
        await baseRemoteDataSource.getWeatherInfoForCurrentCity(cityName);
    return currentCityWeatherResult;
  }
}
