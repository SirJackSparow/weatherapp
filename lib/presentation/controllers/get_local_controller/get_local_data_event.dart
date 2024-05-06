

part of 'get_local_data_bloc.dart';

abstract class GetLocalDataEvent extends Equatable {
  const GetLocalDataEvent();
}

class GetLocalDataInitialWeather extends GetLocalDataEvent{

  @override
  List<Object?> get props => [];
}

class GetLocalDataWeatherEvent extends GetLocalDataEvent{
  const GetLocalDataWeatherEvent();

  @override
  List<Object?> get props => [];
}
