part of 'get_local_data_bloc.dart';

abstract class GetLocalDataState extends Equatable {
   const GetLocalDataState();
}

class GetLocalDataInitial extends GetLocalDataState{
  @override
  List<Object?> get props => [];

}

class GetLocalDataLoaded extends GetLocalDataState{
  final WeatherModel weatherModel;
  const GetLocalDataLoaded(this.weatherModel);

  @override
  List<Object?> get props => [weatherModel];
}

class GetLocalDataWeatherError extends GetLocalDataState {
  final String errorMessage;
  const GetLocalDataWeatherError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
