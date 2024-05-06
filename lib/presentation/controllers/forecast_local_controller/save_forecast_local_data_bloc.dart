
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/forecast_entity.dart';
import '../../../domain/usecases/forecast_usecases.dart';

part 'save_forecast_local_data_state.dart';
part 'save_forecast_local_data_event.dart';

class SaveForeCastBloc extends Bloc<SaveForeCastLocalDataEvent,SaveForeCastLocalState> {
  final ForecastUseCase forecastUseCase;

  SaveForeCastBloc(this.forecastUseCase) : super(SaveForeCastDataInitial()){
    on<SaveForeCastData>((event, emit) async {
      final result = await forecastUseCase.saveLocalForecast(event.foreCastModel);
      result.fold((left) => emit(DataForeCastError(left)), (right) => emit(DataForeCastSaved(right)));
    });
  }
}