import 'package:hive/hive.dart';
import 'package:weatherapps/data/entity/weather_local_entity.dart';

class WeatherAdapter extends TypeAdapter<WeatherLocalEntity> {
  @override
  WeatherLocalEntity read(BinaryReader reader) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WeatherLocalEntity obj) {
    // TODO: implement write
  }
}
