import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/domain/usecases/get_local_data_usecase.dart';
part 'get_local_data_event.dart';
part 'get_local_data_state.dart';

class GetLocalDataBloc extends Bloc<GetLocalDataEvent,GetLocalDataState> {
  final GetLocalDataUseCase getLocalDataUseCase;

  GetLocalDataBloc(this.getLocalDataUseCase): super(GetLocalDataInitial()){
    on<GetLocalDataInitialWeather>((event, emit) async {
      emit(GetLocalDataInitial());
    });

    on<GetLocalDataWeatherEvent>((event, emit) async {
      final result = await getLocalDataUseCase.getUserDataLocal();
      result.fold((left) => emit(GetLocalDataWeatherError(left)),
          (right) => emit(GetLocalDataLoaded(right)));
    });
  }
}
