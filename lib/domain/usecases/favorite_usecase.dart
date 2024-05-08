import 'package:either_dart/either.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/domain/base_repository/base_repository.dart';

class FavoriteUseCase {
  final BaseRemoteRepository baseRemoteRepository;

  FavoriteUseCase(this.baseRemoteRepository);

  Future<Either<String,List<WeatherModel>>> getFavorite() async{
    return await baseRemoteRepository.getFavorite();
  }

  Future<Either<String, WeatherModel>> saveFavorite(WeatherModel weatherModel) async{
    return await baseRemoteRepository.saveFavorite(weatherModel);
  }
}