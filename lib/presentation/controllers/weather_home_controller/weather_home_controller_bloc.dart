import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/domain/usecases/weatherapp_usecases.dart';

part 'weather_home_controller_state.dart';
part 'weather_home_controller_event.dart';

class WeatherHomeControllerBloc
    extends Bloc<WeatherControllerEvent, WeatherHomeControllerState> {
  final WeatherAppUseCases weatherAppUseCases;

  WeatherHomeControllerBloc(this.weatherAppUseCases)
      : super(WeatherControllerInitial()) {
    on<GetInitialEvent>((event, emit) async {
      emit(WeatherControllerInitial());
    });

    on<GetCurrentCityWeatherInfo>((event, emit) async {
      emit(CurrentCityWeatherInfoLoading());
      final result =
          await weatherAppUseCases.getCurrentCityWeather(event.currentCityName);
      result.fold((left) => emit(CurrentCityWeatherInfoLoadingError(left)),
          (right) => emit(CurrentCityDataLoaded(right)));
    });
  }
}
