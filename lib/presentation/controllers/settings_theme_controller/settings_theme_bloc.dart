
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/domain/usecases/setting_usecase.dart';

part 'settings_theme_state.dart';
part 'settings_theme_event.dart';

class SettingsThemeBloc extends Bloc<SettingsEvent, SettingsThemeState>{
  final SettingUseCase settingUseCase;
  SettingsThemeBloc(this.settingUseCase) : super(SettingInitialState()) {
    on<SettingInitialEvent>((event, emit) async{
      emit(SettingInitialState());
    });

    on<GetSettingsThemeEvent>((event, emit) async{
      final result = await settingUseCase.getTheme();
      result.fold((left) => emit(SettingError(left)), (right) => emit(GetSettingTheme(right)));
    });

    on<SetSettingsThemeEvent>((event, emit) async{
       final result = await settingUseCase.setTheme(event.themes);
       result.fold((left) => emit(SettingError(left)), (right) => emit(SetSettingTheme(right)));
    });
  }
}