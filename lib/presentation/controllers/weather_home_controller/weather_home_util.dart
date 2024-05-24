
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../data/entity/weather_entity.dart';
import '../localdatabase_controller/save_data_local_bloc.dart';

class WeatherHomeUtils {
  static void saveCity(WeatherModel weatherModel, BuildContext context) {
    final userBloc = BlocProvider.of<SaveDataLocalBloc>(context);
    userBloc.add(SaveLocalData(weatherModel));
  }
}