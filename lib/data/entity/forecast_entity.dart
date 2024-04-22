class ForeCastModel {
  ForeCastModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  final String? cod;
  final int? message;
  final int? cnt;
  final List<ListElement> list;
  final City? city;

  factory ForeCastModel.fromJson(Map<String, dynamic> json) {
    return ForeCastModel(
      cod: json["cod"],
      message: json["message"],
      cnt: json["cnt"],
      list: json["list"] == null
          ? []
          : List<ListElement>.from(
              json["list"]!.map((x) => ListElement.fromJson(x))),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
    );
  }
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      name: json["name"],
      coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
      country: json["country"],
      population: json["population"],
      timezone: json["timezone"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json["lat"],
      lon: json["lon"],
    );
  }
}

class ListElement {
  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    required this.rain,
  });

  final int? dt;
  final Main? main;
  final List<Weather> weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Sys? sys;
  final DateTime? dtTxt;
  final Rain? rain;

  factory ListElement.fromJson(Map<String, dynamic> json) {
    return ListElement(
      dt: json["dt"],
      main: json["main"] == null ? null : Main.fromJson(json["main"]),
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => Weather.fromJson(x))),
      clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
      wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
      visibility: json["visibility"],
      pop: json["pop"],
      sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
      dtTxt: DateTime.tryParse(json["dt_txt"] ?? ""),
      rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    );
  }
}

class Clouds {
  Clouds({
    required this.all,
  });

  final int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json["all"],
    );
  }
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json["temp"],
      feelsLike: json["feels_like"],
      tempMin: json["temp_min"],
      tempMax: json["temp_max"],
      pressure: json["pressure"],
      seaLevel: json["sea_level"],
      grndLevel: json["grnd_level"],
      humidity: json["humidity"],
      tempKf: json["temp_kf"],
    );
  }
}

class Rain {
  Rain({
    required this.the3H,
  });

  final double? the3H;

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      the3H: json["3h"],
    );
  }
}

class Sys {
  Sys({
    required this.pod,
  });

  final String? pod;

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json["pod"],
    );
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json["speed"],
      deg: json["deg"],
      gust: json["gust"],
    );
  }
}
