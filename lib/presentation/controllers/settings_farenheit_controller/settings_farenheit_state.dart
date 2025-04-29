part of 'setting_farenheit_bloc.dart';

abstract class SettingsFarenheitState extends Equatable{
  const SettingsFarenheitState();
}

class SettingFarenHeitInitialState extends SettingsFarenheitState{
  const SettingFarenHeitInitialState();
  @override
  List<Object?> get props => [];
}

class GetSettingFarenheit extends SettingsFarenheitState {
  final bool farenheit;
  const GetSettingFarenheit(this.farenheit);

  @override
  List<Object?> get props => [farenheit];
}

class SetSettingFarenheit extends SettingsFarenheitState{
  final bool farenheit;
  const SetSettingFarenheit(this.farenheit);
  @override
  List<Object?> get props => [farenheit];

}

class SettingError extends SettingsFarenheitState {
  final String errorMessage;
  const SettingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}