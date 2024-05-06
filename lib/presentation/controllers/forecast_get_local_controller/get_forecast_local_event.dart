part of 'get_forecast_local_bloc.dart';

abstract class GetLocalForeCastEvent extends Equatable {
  const GetLocalForeCastEvent();
}

class GetForeCastInitialEvent extends GetLocalForeCastEvent{
  @override
  List<Object?> get props => [];

}

class GetForeCastLocalDataEvent extends GetLocalForeCastEvent{
  const GetForeCastLocalDataEvent();

  @override
  List<Object?> get props => [];
}
