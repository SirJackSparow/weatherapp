
part of 'save_forecast_local_data_bloc.dart';

abstract class SaveForeCastLocalState extends Equatable{
  const SaveForeCastLocalState();
}

class SaveForeCastDataInitial extends SaveForeCastLocalState {
  @override
  List<Object?> get props => [];
}

class DataForeCastSaved extends SaveForeCastLocalState {
  final ForeCastModel foreCastModel;
  const DataForeCastSaved(this.foreCastModel);

  @override
  // TODO: implement props
  List<Object?> get props => [foreCastModel];

}

class DataForeCastError extends SaveForeCastLocalState {
  final String errorMessage;
  const DataForeCastError(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}