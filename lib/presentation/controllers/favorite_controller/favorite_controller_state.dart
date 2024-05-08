part of 'favorite_controller_bloc.dart';



abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitialState extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteDataLoaded extends FavoriteState{
  final List<WeatherModel> weatherModel;
  const FavoriteDataLoaded(this.weatherModel);
  @override
  List<Object?> get props => [weatherModel];
}

class DataSaved extends FavoriteState{
  final WeatherModel weatherModel;
  const DataSaved(this.weatherModel);
  @override
  List<Object?> get props => [weatherModel];
}

class FavoriteError extends FavoriteState{
  final String errorMessage;

  const FavoriteError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

}