part of 'weather_home_controller_bloc.dart';

abstract class WeatherControllerEvent extends Equatable {
  const WeatherControllerEvent();
}

class GetInitialEvent extends WeatherControllerEvent {
  @override
  List<Object?> get props => [];
}

class GetCurrentCityWeatherInfo extends WeatherControllerEvent {
  final String currentCityName;

  const GetCurrentCityWeatherInfo(this.currentCityName);

  @override
  // TODO: implement props
  List<Object?> get props => [currentCityName];
}
