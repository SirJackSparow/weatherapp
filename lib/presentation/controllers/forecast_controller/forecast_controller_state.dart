part of 'forecast_controller_bloc.dart';

abstract class ForecastControllerState extends Equatable {
  const ForecastControllerState();
}

class ForecastControllerInitial extends ForecastControllerState {
  @override
  List<Object> get props => [];
}

class ForecastLoading extends ForecastControllerState {
  @override
  List<Object> get props => [];
}

class ForecastError extends ForecastControllerState {
  final String errorMessage;
  const ForecastError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class ForecastLoaded extends ForecastControllerState {
  final ForeCastModel foreCastModel;
  const ForecastLoaded(this.foreCastModel);
  @override
  List<Object> get props => [foreCastModel];
}
