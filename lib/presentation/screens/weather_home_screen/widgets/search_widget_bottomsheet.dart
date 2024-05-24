import 'package:flutter/material.dart';
import 'package:weatherapps/const/app_extentions.dart';
import 'package:weatherapps/const/utils/utils.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/const/utils/weather_height_width.dart';
import 'package:weatherapps/const/utils/weather_paddings.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(WeatherAppPaddings.s16),
      height: double.infinity,
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: WeatherAppString.search,
              border: const OutlineInputBorder(),
            ),
          ),
          WeatherAppHeight.h15.sizeHeight,
          ElevatedButton(
            onPressed: () {
              HomeUtils.searchCity(_controller.text, context);
              Navigator.pop(context);
            },
            child: Text(WeatherAppString.search),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
