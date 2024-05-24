
part of 'settings_theme_bloc.dart';

abstract class SettingsThemeState extends Equatable{
  const SettingsThemeState();
}

class SettingInitialState extends SettingsThemeState{
  @override
  List<Object?> get props => [];
}

class GetSettingTheme extends SettingsThemeState {
  final bool themes;
  const GetSettingTheme(this.themes);

  @override
  List<Object?> get props => [themes];
}

class SetSettingTheme extends SettingsThemeState{
  final bool themes;
  const SetSettingTheme(this.themes);
  @override
  List<Object?> get props => [themes];

}

class SettingError extends SettingsThemeState {
  final String errorMessage;
  const SettingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
