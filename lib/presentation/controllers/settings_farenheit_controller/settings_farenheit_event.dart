part of 'setting_farenheit_bloc.dart';

abstract class SettingsFarenheitEvent extends Equatable{
   const SettingsFarenheitEvent();
}

class SettingFarenHeitInitialEvent extends SettingsFarenheitEvent{
  const SettingFarenHeitInitialEvent();
  @override
  List<Object?> get props => [];
}

class GetSettingsFarenHeitEvent extends SettingsFarenheitEvent{
  @override
  List<Object?> get props => [];
}

class SetSettingsFarenheitEvent extends SettingsFarenheitEvent{
  final bool farenheit;
  const SetSettingsFarenheitEvent(this.farenheit);
  @override
  List<Object?> get props => [farenheit];

}
