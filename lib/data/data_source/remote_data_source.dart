import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/data/shared_pref/sharedprefs_service.dart';
import 'package:weatherapps/domain/base_data_source/base_remote_data_source.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/data/network/services.dart';

import '../localdatabase/app_database.dart';

class RemoteDataSource extends BaseRemoteDataSource {
  final AppDatabase _appDatabase;
  Dio dio = Dio();
  static const String CityName = 'cities';
  static const String Forecast = 'forecast';
  static const String Favorite = 'favorite';
  final cityNameStore = intMapStoreFactory.store(CityName);
  final foreCastStore = intMapStoreFactory.store(Forecast);
  final favoriteStore = intMapStoreFactory.store(Favorite);

  RemoteDataSource() : _appDatabase = GetIt.instance<AppDatabase>();

  Future<Database> get _db async => await _appDatabase.database;

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
        return Left(' ${e.toString()}!');
      }
    }
  }

  @override
  Future<Either<String, WeatherModel>> saveWeatherLocalData(
      WeatherModel weatherModel) async {
    try {
      final cityNameNormalized = normalizeCityName(weatherModel.name);
      final existingRecord = await cityNameStore.find(await _db,
          finder: Finder(filter: Filter.custom((record) {
        final recordNameNormalized =
            normalizeCityName(record['name'] as String);
        return recordNameNormalized == cityNameNormalized;
      })));

      if (existingRecord.isNotEmpty) {
        final existingWeatherModel =
            WeatherModel.fromJson(existingRecord.first.value);
        return Right(existingWeatherModel);
      }

      await cityNameStore.add(await _db, weatherModel.toJson());
      return Right(weatherModel);
    } catch (e) {
      return Left('${WeatherAppString.dataInsertFailed} ${e.toString()}');
    }
  }

  String normalizeCityName(String name) {
    return name.toLowerCase().trim();
  }

  @override
  Future<Either<String, WeatherModel>> getWeatherFromLocal() async {
    try {
      final recordsSnapshots = await cityNameStore.find(await _db);
      if (recordsSnapshots.isEmpty) {
        return const Left('No Data');
      }
      final recordSnapshot = recordsSnapshots.first;
      final weatherModel = WeatherModel.fromJson(recordSnapshot.value);
      return Right(weatherModel);
    } catch (e) {
      log(e.toString());
      return Left('Local database error ${e.toString()}');
    }
  }

  @override
  Future<Either<String, ForeCastModel>> saveForeCast(
      ForeCastModel foreCastModel) async {
    try {
      await foreCastStore.delete(await _db);
      await foreCastStore.add(await _db, foreCastModel.toJson());
      return Right(foreCastModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, WeatherModel>> saveFavorite(
      WeatherModel weatherModel) async {
    try {
      final cityNameNormalized = normalizeCityName(weatherModel.name);
      final existingRecord = await favoriteStore.find(await _db,
          finder: Finder(filter: Filter.custom((record) {
        final recordNameNormalized =
            normalizeCityName(record['name'] as String);
        return recordNameNormalized == cityNameNormalized;
      })));

      if (existingRecord.isNotEmpty) {
        final existingWeatherModel =
            WeatherModel.fromJson(existingRecord.first.value);
        await favoriteStore.record(weatherModel.id).delete(await _db);
        log(existingWeatherModel.id.toString() + ""  + existingWeatherModel.name);
        return Right(existingWeatherModel);
      }
      await favoriteStore.record(weatherModel.id).add(await _db, weatherModel.toJson());
      return Right(weatherModel);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, WeatherModel>> deleteFavorite() {
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<WeatherModel>>> getFavorite() async {
    try {
      final favoriteData = await favoriteStore.find(await _db);
      final favoritesModel = favoriteData.map((snapshot) {
        return WeatherModel.fromJson(snapshot.value);
      }).toList();

      return Right(favoritesModel);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ForeCastModel>> getForecastLocalData() async {
    try {
      final foreCast = await foreCastStore.find(await _db);
      if (foreCast.isEmpty) {
        return const Left('No Data');
      }
      final getForeCast = foreCast.first;
      final foreCastModel = ForeCastModel.fromJson(getForeCast.value);
      return Right(foreCastModel);
    } catch (e) {
      return Left('Local db ${e.toString()}');
    }
  }

  @override
  Future<Either<String, bool>> getFarenheit() async {
    try {
      final farenheit =
          await SharedprefsService.getData(WeatherAppString.isFarenheit);
      return Right(farenheit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> getTheme() async {
    try {
      final theme =
          await SharedprefsService.getData(WeatherAppString.isDarkTheme);
      return Right(theme);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> setFarenheit(bool farenheit) async {
    try {
      await SharedprefsService.isFarenHeit(farenheit);
      return Right(farenheit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> setTheme(bool theme) async {
    try {
      await SharedprefsService.isDarkTheme(theme);
      return Right(theme);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
