
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/domain/usecases/favorite_usecase.dart';

import '../../../data/entity/weather_entity.dart';

part 'favorite_controller_event.dart';
part 'favorite_controller_state.dart';


class FavoriteBloc extends Bloc<FavoriteEvent,FavoriteState> {
  final FavoriteUseCase favoriteUseCase;

  FavoriteBloc(this.favoriteUseCase) : super(FavoriteInitialState()){
    on<FavoriteInitialEvent>((event, emit) async{
      emit(FavoriteInitialState());
    });

    on<GetFavoriteEvent>((event, emit) async{
      final result = await favoriteUseCase.getFavorite();
      result.fold((left) => emit(FavoriteError(left)), (right) => emit(FavoriteDataLoaded(right)));
    });

    on<FavoriteSaveEvent>((event, emit) async{
      final result = await favoriteUseCase.saveFavorite(event.weatherModel);
      result.fold((left) => emit(FavoriteError(left)), (right) => emit(DataSaved(right)));
    });
  }

}