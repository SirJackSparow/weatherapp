
part of 'settings_theme_bloc.dart';

abstract class SettingsEvent extends Equatable{
  const SettingsEvent();
}

class SettingInitialEvent extends SettingsEvent{
  @override
  List<Object?> get props => [];
}

class GetSettingsThemeEvent extends SettingsEvent{
  @override
  List<Object?> get props => [];
}

class SetSettingsThemeEvent extends SettingsEvent{

  final bool themes;

  const SetSettingsThemeEvent(this.themes);
  @override
  List<Object?> get props => [themes];

}
