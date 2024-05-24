import 'package:either_dart/either.dart';
import 'package:weatherapps/domain/base_data_source/base_remote_data_source.dart';

class SettingUseCase {
  final BaseRemoteDataSource baseRemoteDataSource;

  SettingUseCase(this.baseRemoteDataSource);

  Future<Either<String,bool>> getTheme() async {
    return await baseRemoteDataSource.getTheme();
  }

  Future<Either<String,bool>> getFarenheit() async {
    return await baseRemoteDataSource.getFarenheit();
  }

  Future<Either<String,bool>> setTheme(bool theme) async {
    return await baseRemoteDataSource.setTheme(theme);
  }

  Future<Either<String,bool>> setFarenheit(bool farenheit) async {
    return await baseRemoteDataSource.setFarenheit(farenheit);
  }
}
