import 'dart:math';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/domain/base_data_source/base_remote_data_source.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/data/network/services.dart';

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<Either<String, WeatherModel>> getWeatherInfoForCurrentCity(
      String cityName) async {
    Map<String, dynamic> queryParameters = {
      'q': cityName,
      'units': 'metric',
      'appid': WeatherAppServices.apiKey
    };
    try {
      Response response = await Dio().get(
          WeatherAppServices.baseURL + WeatherAppServices.weather,
          queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final data = WeatherModel.fromJson(response.data);
        return Right(data);
      } else {
        return Left("Error${response.statusCode}");
      }
    } catch (e, s) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          return const Left("Error Not Found");
        } else {
          return Left('Error ${e.response?.data['message'] ?? e.message}');
        }
      } else {
        return const Left('Error An unexpected Error occured');
      }
    }
  }

  @override
  Future<Either<String, ForeCastModel>> getForecast(String cityName) async {
    Map<String, dynamic> queryParameters = {
      'q': cityName,
      'appid': WeatherAppServices.apiKey
    };

    try {
      Response response = await Dio().get(
          WeatherAppServices.baseURL + WeatherAppServices.forecast,
          queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final data = ForeCastModel.fromJson(response.data);
        return Right(data);
      } else {
        return Left("Error${response.statusCode}");
      }
    } catch (e, s) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          return const Left("Error Not Found");
        } else {
          return Left('Error ${e.response?.data['message'] ?? e.message}');
        }
      } else {
        return Left(' ${e.toString()} !!!!!!');
      }
    }
  }
}
