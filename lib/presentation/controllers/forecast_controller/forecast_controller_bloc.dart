import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';

part 'forecast_controller_state.dart';
part 'forecast_controller_event.dart';

class ForecastControllerBloc
    extends Bloc<ForecastEvent, ForecastControllerState> {
  ForecastControllerBloc() : super(ForecastControllerInitial()) {
    on<GetInitialForecastEvent>((event, emit) async {});
  }
}
