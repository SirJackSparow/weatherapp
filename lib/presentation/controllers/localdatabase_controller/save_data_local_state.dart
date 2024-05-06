
part of 'save_data_local_bloc.dart';

abstract class SaveLocalDataState extends Equatable {
  const SaveLocalDataState();
}

class SaveLocalDataInitial extends SaveLocalDataState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DataSaved extends SaveLocalDataState{
  final WeatherModel weatherModel;
  const DataSaved(this.weatherModel);

  @override
  // TODO: implement props
  List<Object?> get props => [weatherModel];
}

class DataError extends SaveLocalDataState{

  final String errorMessage;
  const DataError(this.errorMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];

}