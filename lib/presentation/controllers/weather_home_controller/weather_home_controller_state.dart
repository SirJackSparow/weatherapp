part of 'weather_home_controller_bloc.dart';

abstract class WeatherHomeControllerState extends Equatable {
  const WeatherHomeControllerState();
}

class WeatherControllerInitial extends WeatherHomeControllerState {
  @override
  List<Object> get props => [];
}

/// current city weather info loading
class CurrentCityWeatherInfoLoading extends WeatherHomeControllerState {
  @override
  List<Object?> get props => [];
}

/// loading current city error
class CurrentCityWeatherInfoLoadingError extends WeatherHomeControllerState {
  final String errorMessage;
  const CurrentCityWeatherInfoLoadingError(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

/// get current city data
class CurrentCityDataLoaded extends WeatherHomeControllerState {
  final WeatherModel currentCityData;
  const CurrentCityDataLoaded(this.currentCityData);
  @override
  // TODO: implement props
  List<Object?> get props => [currentCityData];
}
