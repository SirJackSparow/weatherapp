import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/domain/usecases/forecast_usecases.dart';

part 'forecast_controller_state.dart';
part 'forecast_controller_event.dart';

class ForecastControllerBloc
    extends Bloc<ForecastEvent, ForecastControllerState> {
  final ForecastUseCase forecastUseCase;

  ForecastControllerBloc(this.forecastUseCase)
      : super(ForecastControllerInitial()) {
    on<GetInitialForecastEvent>((event, emit) async {
      emit(ForecastControllerInitial());
    });

    on<GetForecast>((event, emit) async {
      emit(ForecastLoading());
      final result = await forecastUseCase.getForecast(event.cityName);
      result.fold((left) => emit(ForecastError(left)),
          (right) => emit(ForecastLoaded(right)));
    });
  }
}
