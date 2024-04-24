import 'package:hive/hive.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/data/localdb/coor_adapter.dart';
import 'package:weatherapps/data/localdb/main_adapter.dart';
import 'package:weatherapps/data/localdb/wind_adapter.dart';

class WeatherLocalEntity extends HiveObject {
  final Coor coord;
  final List<WeatherElement> weather;
  final String base;
  final Mains main;
  final int visibility;
  final Winds wind;
  final int dt;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  final String updatedAt;
  String? cityImageURL;
  bool? isCurrentCity;
  final List<ListLocalElement> list;

  WeatherLocalEntity(
      this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.dt,
      this.timezone,
      this.id,
      this.name,
      this.cod,
      this.updatedAt,
      this.cityImageURL,
      this.isCurrentCity,
      this.list);
}

class ListLocalElement {
  ListLocalElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.dtTxt,
  });

  final num? dt;
  final Main? main;
  final List<Weather> weather;
  final Clouds? clouds;
  final Wind? wind;
  final DateTime? dtTxt;
}

class Weather {
  Weather({
    required this.main,
    required this.description,
    required this.icon,
  });

  final String? main;
  final String? description;
  final String? icon;
}
