import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/domain/usecases/weatherapp_usecases.dart';
import '../../../data/entity/weather_entity.dart';

part 'save_data_local_event.dart';
part 'save_data_local_state.dart';

class SaveDataLocalBloc extends Bloc<SaveLocalDataEvent, SaveLocalDataState>{
  final WeatherAppUseCases weatherAppUseCases;

  SaveDataLocalBloc(this.weatherAppUseCases) : super(SaveLocalDataInitial()) {
    on<SaveLocalData>((event, emit) async {
      final result = await weatherAppUseCases.saveLocalDatabase(event.weatherModel);
      result.fold((left) => emit(DataError(left)), (right) => emit(DataSaved(right)));
    });
  }
}