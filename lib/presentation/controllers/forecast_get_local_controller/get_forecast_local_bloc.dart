
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/domain/usecases/get_local_data_usecase.dart';

part 'get_forecast_local_event.dart';
part 'get_forecast_local_state.dart';

class GetForeCastBloc extends Bloc<GetLocalForeCastEvent,GetForeCastState> {
  final GetLocalDataUseCase getLocalDataUseCase;

  GetForeCastBloc(this.getLocalDataUseCase) : super(GetForeCastInitial()) {
    on<GetForeCastInitialEvent>((event, emit) async {
      emit(GetForeCastInitial());
    });

    on<GetForeCastLocalDataEvent>((event, emit) async {
      final result = await getLocalDataUseCase.getForeCastDataLocal();
      result.fold((left) => emit(GetForeCastError(left)), (right) => emit(GetForeCastLoaded(right)));
    });
  }
}