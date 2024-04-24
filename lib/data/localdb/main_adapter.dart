import 'package:hive/hive.dart';

class Mains extends HiveObject {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  Mains(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.humidity);
}

class MainAdapter extends TypeAdapter<Mains> {
  @override
  Mains read(BinaryReader reader) {
    final temp = reader.readDouble();
    final feelsLike = reader.readDouble();
    final tempMin = reader.readDouble();
    final tempMax = reader.readDouble();
    final pressure = reader.readInt();
    final humidity = reader.readInt();

    return Mains(temp, feelsLike, tempMin, tempMax, pressure, humidity);
  }

  @override
  // TODO: implement typeId
  int get typeId => 3;

  @override
  void write(BinaryWriter writer, Mains obj) {
    writer.writeDouble(obj.temp);
    writer.writeDouble(obj.feelsLike);
    writer.writeDouble(obj.tempMin);
    writer.writeDouble(obj.tempMax);
    writer.writeInt(obj.pressure);
    writer.writeInt(obj.humidity);
  }
}
