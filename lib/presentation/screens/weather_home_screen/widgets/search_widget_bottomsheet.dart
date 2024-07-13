import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/const/app_extentions.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/const/utils/weather_height_width.dart';
import 'package:weatherapps/const/utils/weather_paddings.dart';

import '../../../controllers/forecast_controller/forecast_controller_bloc.dart';
import '../../../controllers/weather_home_controller/weather_home_controller_bloc.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  List<String> cities = [];
  List<String> filteredCities = [];

  @override
  void initState() {
    super.initState();
    _loadCities().then((value) {
      setState(() {
        cities = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(WeatherAppPaddings.s16),
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.close, color: Colors.red,)),
          TextField(
            controller: _controller,
            onChanged: (value) {
              _filterCities(value);
            },
            decoration: InputDecoration(
              labelText: WeatherAppString.search,
              border: const OutlineInputBorder(),
            ),
          ),
          WeatherAppHeight.h15.sizeHeight,
          Expanded(child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredCities[index]),
                  onTap: () {
                    _searchCity(filteredCities[index], context);
                    Navigator.pop(context);
                  },
                );
              })),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<String>> _loadCities() async {
    String data = await rootBundle.loadString('assets/cities.json');
    List<dynamic> cities = json.decode(data);
    return cities.map((city) => city['name'].toString()).toList();
  }

  void _filterCities(String query) {
    List<String> filteredList = [];
    if (query.isNotEmpty) {
      cities.forEach((city) {
        if (city.toLowerCase().startsWith(query.toLowerCase())) {
          filteredList.add(city);
        }
      });
    } else {
      filteredList = List.from(cities);
    }
    setState(() {
      filteredCities = filteredList;
    });
  }

  void _searchCity(String cityName, BuildContext context) async {
    final weatherCityBloc = BlocProvider.of<WeatherHomeControllerBloc>(context);
    weatherCityBloc.add(GetCurrentCityWeatherInfo(cityName));
    await _forecast(cityName, context);
  }

   _forecast(String cityName, BuildContext context) {
    final foreCastBloc = BlocProvider.of<ForecastControllerBloc>(context);
    foreCastBloc.add(GetForecast(cityName));
  }
}
