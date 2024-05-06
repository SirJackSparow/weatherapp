import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';

class ForecastUseCase {
  final BaseRemoteRepository baseRemoteRepository;

  ForecastUseCase(this.baseRemoteRepository);

  Future<Either<String, ForeCastModel>> getForecast(String cityName) async {
    return await baseRemoteRepository.getForecast(cityName);
  }

  Future<Either<String, ForeCastModel>> saveLocalForecast(ForeCastModel foreCastModel) async{
    return await baseRemoteRepository.saveForeCastData(foreCastModel);
  }
}
