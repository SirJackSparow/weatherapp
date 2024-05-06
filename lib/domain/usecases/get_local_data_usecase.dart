import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';

class GetLocalDataUseCase {
  final BaseRemoteRepository baseRemoteRepository;

  GetLocalDataUseCase(this.baseRemoteRepository);

  Future<Either<String,WeatherModel>> getUserDataLocal() async {
    return await baseRemoteRepository.getWeatherLocalData();
  }

  Future<Either<String,ForeCastModel>> getForeCastDataLocal() async{
    return await baseRemoteRepository.getForeCastData();
  }
}