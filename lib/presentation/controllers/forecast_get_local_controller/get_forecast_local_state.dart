
part of 'get_forecast_local_bloc.dart';

abstract class GetForeCastState extends Equatable {
   const GetForeCastState();
}

class GetForeCastInitial extends GetForeCastState{
  @override
  List<Object?> get props => [];
}

class GetForeCastLoaded extends GetForeCastState{
  final ForeCastModel foreCastModel;
  const GetForeCastLoaded(this.foreCastModel);

  @override
  List<Object?> get props => [foreCastModel];

}

class GetForeCastError extends GetForeCastState{
  final String errorMessage;
  const GetForeCastError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];

}