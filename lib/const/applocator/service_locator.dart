import 'package:get_it/get_it.dart';
import 'package:weatherapps/data/data_source/remote_data_source.dart';
import 'package:weatherapps/data/remote_repository/remote_repository.dart';
import 'package:weatherapps/domain/base_data_source/base_remote_data_source.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';
import 'package:weatherapps/domain/usecases/forecast_usecases.dart';
import 'package:weatherapps/domain/usecases/weatherapp_usecases.dart';
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
    appServiceLocator.registerLazySingleton<BaseRemoteRepository>(
        () => WeatherRepository(appServiceLocator()));
    appServiceLocator
        .registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  }
}
