import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
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

  @override
  Future<Either<String, ForeCastModel>> getForecast(String cityName) async {
    final forecastResult = await baseRemoteDataSource.getForecast(cityName);
    return forecastResult;
  }

  @override
  Future<Either<String, WeatherModel>> saveWeatherLocalData(WeatherModel weatherModel) async {
    final saveWeatherLocalDatabase = await baseRemoteDataSource.saveWeatherLocalData(weatherModel);
    return saveWeatherLocalDatabase;
  }

  @override
  Future<Either<String, WeatherModel>> getWeatherLocalData() async{
    final getLocalData = await baseRemoteDataSource.getWeatherFromLocal();
    return getLocalData;
  }

  @override
  Future<Either<String, ForeCastModel>> getForeCastData() async{
    final getLocalData = await baseRemoteDataSource.getForecastLocalData();
    return getLocalData;
  }

  @override
  Future<Either<String, ForeCastModel>> saveForeCastData(ForeCastModel foreCastModel) async{
    final foreCastData = await baseRemoteDataSource.saveForeCast(foreCastModel);
    return foreCastData;
  }
}
