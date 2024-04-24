import 'package:hive/hive.dart';

class Winds extends HiveObject {
  final double speed;
  final int deg;

  Winds(this.speed, this.deg);
}

class WindAdapter extends TypeAdapter<Winds> {
  @override
  Winds read(BinaryReader reader) {
    final speed = reader.readDouble();
    final deg = reader.readInt();
    return Winds(speed, deg);
  }

  @override
  // TODO: implement typeId
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, Winds obj) {
    writer.writeDouble(obj.speed);
    writer.writeInt(obj.deg);
  }
}
