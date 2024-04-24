import 'package:hive/hive.dart';

class Coor extends HiveObject {
  final double lon;
  final double lat;

  Coor(this.lon, this.lat);
}

class CoorAdapter extends TypeAdapter<Coor> {
  @override
  Coor read(BinaryReader reader) {
    final lon = reader.readDouble();
    final lat = reader.readDouble();
    return Coor(lon, lat);
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Coor obj) {
    writer.writeDouble(obj.lon);
    writer.writeDouble(obj.lat);
  }
}
