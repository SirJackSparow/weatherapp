import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/domain/usecases/setting_usecase.dart';

part 'settings_farenheit_event.dart';
part 'settings_farenheit_state.dart';

class SettingFarenheitBloc extends Bloc<SettingsFarenheitEvent,SettingsFarenheitState>{
  SettingUseCase settingUseCase;
  SettingFarenheitBloc(this.settingUseCase) : super(SettingFarenHeitInitialState()) {
    on<SettingFarenHeitInitialEvent>((event, emit) async{
      emit(SettingFarenHeitInitialState());
    });

    on<SetSettingsFarenheitEvent>((event,emit) async{
      final result = await settingUseCase.setFarenheit(event.farenheit);
      result.fold((left) => emit(SettingError(left)), (right) => emit(SetSettingFarenheit(right)));
    });

    on<GetSettingsFarenHeitEvent>((event, emit) async{
      final result = await settingUseCase.getFarenheit();
      result.fold((left) => emit(SettingError(left)), (right) => emit(GetSettingFarenheit(right)));
    });
  }
}