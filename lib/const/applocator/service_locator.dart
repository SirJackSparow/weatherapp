import 'package:get_it/get_it.dart';
import 'package:weatherapps/data/data_source/remote_data_source.dart';
import 'package:weatherapps/data/localdatabase/app_database.dart';
import 'package:weatherapps/data/remote_repository/remote_repository.dart';
import 'package:weatherapps/domain/base_data_source/base_remote_data_source.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';
import 'package:weatherapps/domain/usecases/favorite_usecase.dart';
import 'package:weatherapps/domain/usecases/forecast_usecases.dart';
import 'package:weatherapps/domain/usecases/get_local_data_usecase.dart';
import 'package:weatherapps/domain/usecases/weatherapp_usecases.dart';
import 'package:weatherapps/presentation/controllers/favorite_controller/favorite_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_get_local_controller/get_forecast_local_bloc.dart';
import 'package:weatherapps/presentation/controllers/forecast_local_controller/save_forecast_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/get_local_controller/get_local_data_bloc.dart';
import 'package:weatherapps/presentation/controllers/localdatabase_controller/save_data_local_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home_controller_bloc.dart';

GetIt appServiceLocator = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    appServiceLocator
        .registerFactory(() => WeatherHomeControllerBloc(appServiceLocator()));
    appServiceLocator
        .registerLazySingleton(() => WeatherAppUseCases(appServiceLocator()));
    appServiceLocator
        .registerLazySingleton(() => ForecastUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton(() => GetLocalDataUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton(() => FavoriteUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton<BaseRemoteRepository>(
        () => WeatherRepository(appServiceLocator()));
    appServiceLocator
        .registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
    appServiceLocator.registerLazySingleton(() => AppDatabase.instance);
    appServiceLocator.registerFactory(() => SaveDataLocalBloc(appServiceLocator()));
    appServiceLocator.registerFactory(() => GetLocalDataBloc(appServiceLocator()));
    appServiceLocator.registerFactory(() => SaveForeCastBloc(appServiceLocator()));
    appServiceLocator.registerFactory(() => GetForeCastBloc(appServiceLocator()));
    appServiceLocator.registerFactory(() => FavoriteBloc(appServiceLocator()));

  }
}
