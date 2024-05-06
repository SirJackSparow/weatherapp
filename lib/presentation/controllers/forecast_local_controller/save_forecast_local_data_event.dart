
part of 'save_forecast_local_data_bloc.dart';

abstract class SaveForeCastLocalDataEvent extends Equatable{
   const SaveForeCastLocalDataEvent();
}

class SaveForeCastData extends SaveForeCastLocalDataEvent {
   final ForeCastModel foreCastModel;

   const SaveForeCastData(this.foreCastModel);

  @override
  // TODO: implement props
  List<Object?> get props => [foreCastModel];

}