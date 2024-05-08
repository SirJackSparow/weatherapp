part of 'favorite_controller_bloc.dart';



abstract class FavoriteEvent extends Equatable{
  const FavoriteEvent();
}

class FavoriteInitialEvent extends FavoriteEvent{
  @override
  List<Object?> get props => [];

}

class GetFavoriteEvent extends FavoriteEvent{
  const GetFavoriteEvent();

  @override
  List<Object?> get props => [];
}

class FavoriteSaveEvent extends FavoriteEvent{
  final WeatherModel weatherModel;

  const FavoriteSaveEvent(this.weatherModel);

  @override
  List<Object?> get props => [weatherModel];
}

