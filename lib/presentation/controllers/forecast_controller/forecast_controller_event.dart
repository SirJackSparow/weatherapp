part of 'forecast_controller_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class GetInitialForecastEvent extends ForecastEvent {
  @override
  List<Object> get props => [];
}

class GetForecast extends ForecastEvent {
  final String cityName;

  const GetForecast(this.cityName);

  @override
  List<Object> get props => [cityName];
}
