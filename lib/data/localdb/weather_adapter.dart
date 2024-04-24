import 'package:hive/hive.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/data/entity/weather_local_entity.dart';
import 'package:weatherapps/data/localdb/coor_adapter.dart';
import 'package:weatherapps/data/localdb/main_adapter.dart';
import 'package:weatherapps/data/localdb/wind_adapter.dart';

class WeatherAdapter extends TypeAdapter<WeatherLocalEntity> {
  @override
  WeatherLocalEntity read(BinaryReader reader) {
    final coord = reader.read() as Coor;
    final weather = reader.readList().cast<WeatherElement>();
    final base = reader.readString();
    final main = reader.read() as Mains;
    final visibility = reader.readInt();
    final wind = reader.read() as Winds;
    final dt = reader.readInt();
    final timezone = reader.readInt();
    final id = reader.readInt();
    final name = reader.readString();
    final cod = reader.readInt();
    final updatedAt = reader.readString();
    final cityImageURL = reader.readString();
    final isCurrentCity = reader.readBool();
    final List<ListLocalElement> list =
        reader.readList().cast<ListLocalElement>();

    return WeatherLocalEntity(coord, weather, base, main, visibility, wind, dt,
        timezone, id, name, cod, updatedAt, cityImageURL, isCurrentCity, list);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WeatherLocalEntity obj) {
    writer.write(obj.coord);
    writer.writeList(obj.weather);
    writer.writeString(obj.base);
    writer.write(obj.main);
    writer.writeInt(obj.visibility);
    writer.write(obj.wind);
    writer.writeInt(obj.dt);
    writer.writeInt(obj.timezone);
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeInt(obj.cod);
    writer.writeString(obj.updatedAt);
    writer.writeString(obj.cityImageURL ?? "");
    writer.writeBool(obj.isCurrentCity ?? false);
    writer.writeList(obj.list);
  }
}
