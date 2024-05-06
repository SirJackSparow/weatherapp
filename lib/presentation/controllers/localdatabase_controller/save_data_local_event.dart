
part of 'save_data_local_bloc.dart';

abstract class SaveLocalDataEvent extends Equatable {
  const SaveLocalDataEvent();
}

class SaveLocalData extends SaveLocalDataEvent {
  final WeatherModel weatherModel;

  const SaveLocalData(this.weatherModel);

  @override
  // TODO: implement props
  List<Object?> get props => [weatherModel];

}