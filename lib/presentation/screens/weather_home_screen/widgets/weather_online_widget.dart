import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapps/const/app_color.dart';
import 'package:weatherapps/const/app_extentions.dart';
import 'package:weatherapps/const/utils/utils.dart';
import 'package:weatherapps/presentation/controllers/favorite_controller/favorite_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/weather_home_controller/weather_home.dart';
import 'package:weatherapps/const/utils/weather_app_fonts.dart';
import 'package:weatherapps/const/utils/weather_app_string.dart';
import 'package:weatherapps/const/utils/weather_font_sizes.dart';
import 'package:weatherapps/const/utils/weather_paddings.dart';
import 'package:weatherapps/data/entity/forecast_entity.dart';
import 'package:weatherapps/data/entity/weather_entity.dart';
import 'package:weatherapps/const/appresources.dart';
import 'package:weatherapps/presentation/commonwidgets/weather_app_bar.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:weatherapps/presentation/controllers/forecast_controller/forecast_controller_bloc.dart';
import 'package:weatherapps/presentation/controllers/settings_farenheit_controller/setting_farenheit_bloc.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/settings_theme_bloc.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/widgets/reusable_container.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/widgets/search_widget_bottomsheet.dart';
import 'package:weatherapps/routes/weather_routes.dart';

import '../../../controllers/forecast_local_controller/save_forecast_local_data_bloc.dart';
import '../../../controllers/settings_theme_controller/setting_theme_util.dart';

class WeatherUIWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherUIWidget({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    _getFavorite(context);
    return BlocBuilder<SettingsThemeBloc, SettingsThemeState>(
        builder: (context, state) {
      return Stack(children: [
        SettingThemeUtil.backGround(state),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                WeatherAppBar(
                    cityNames: weatherModel.name,
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return const SearchBottomSheet();
                          });
                    }),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(top: 79.h),
          child: ListView(
            children: [
              //today
              Padding(
                padding: const EdgeInsets.all(WeatherAppPaddings.s10),
                child: GlassContainer(
                  color: WeatherAppColor.blackColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.0.sizeHeight,
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                        var fav = false;
                        if (state is FavoriteDataLoaded) {
                          if (state.weatherModel.isNotEmpty) {
                            var f = state.weatherModel
                                .where((favorite) =>
                                    favorite.name == weatherModel.name)
                                .toList();
                            if (f.isNotEmpty) {
                              fav = true;
                            }
                          }
                        } else if (state is DataSaved) {
                          _getFavorite(context);
                          fav = true;
                        } else {
                          log(state.toString());
                        }
                        return IconButton(
                          onPressed: () {
                            _saveFavorite(weatherModel, context);
                          },
                          icon: fav
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          color: Colors.amber,
                        );
                      }),
                      Center(
                          child: Text(
                        WeatherHome.today(),
                        style: WeatherAppFonts.large(
                                fontWeight: FontWeight.w400,
                                color: WeatherAppColor.whiteColor)
                            .copyWith(fontSize: WeatherAppFontSize.s30),
                      )),
                      2.0.sizeHeight,

                      /// updated at
                      2.0.sizeHeight,
                      Center(
                          child: Text(
                        Utils.formatDateTime(
                            weatherModel.updatedAt.toIso8601String()),
                        style: WeatherAppFonts.large(
                                fontWeight: FontWeight.w300,
                                color: WeatherAppColor.whiteColor
                                    .withOpacity(0.75))
                            .copyWith(
                          fontSize: WeatherAppFontSize.s16,
                        ),
                      )),

                      /// display data from API
                      Column(
                        children: [
                          10.0.sizeHeight,
                          WeatherHome.getWeatherIcon(
                                      weatherModel.weather[0].icon) !=
                                  WeatherIcons.refresh
                              ? Icon(
                                  WeatherHome.getWeatherIcon(
                                      weatherModel.weather[0].icon),
                                  size: 100.0,
                                  color: WeatherAppColor.yellowColor,
                                )
                              : Image.network(
                                  WeatherHome.getWeatherIconURL(
                                      weatherModel.weather[0].icon),
                                  color: WeatherAppColor.yellowColor,
                                ),
                          10.0.sizeHeight,
                          Text(
                            weatherModel.weather[0].description
                                .capitalizeFirstLater(),
                            style: WeatherAppFonts.large(
                                    fontWeight: FontWeight.w700,
                                    color: WeatherAppColor.whiteColor)
                                .copyWith(fontSize: WeatherAppFontSize.s30),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<SettingFarenheitBloc,
                                      SettingsFarenheitState>(
                                  builder: (context, state) {
                                return setCelcius(state);
                              })
                            ],
                          ),

                          /// humidty... feels like
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image(
                                        image: Svg(
                                            WeatherAppResources.humidtyIcon)),
                                    3.0.sizeHeight,
                                    Text(
                                      WeatherAppString.humidity,
                                      style: WeatherAppFonts.large(
                                              fontWeight: FontWeight.w500,
                                              color: WeatherAppColor.whiteColor)
                                          .copyWith(
                                              fontSize: WeatherAppFontSize.s14),
                                    ),
                                    3.0.sizeHeight,
                                    Text(
                                      "${weatherModel.main.humidity} ${WeatherAppString.percent}",
                                      style: WeatherAppFonts.large(
                                              fontWeight: FontWeight.w500,
                                              color: WeatherAppColor.whiteColor)
                                          .copyWith(
                                              fontSize: WeatherAppFontSize.s14),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image(
                                        image:
                                            Svg(WeatherAppResources.windIcon)),
                                    3.0.sizeHeight,
                                    Text(
                                      WeatherAppString.wind,
                                      style: WeatherAppFonts.large(
                                              fontWeight: FontWeight.w500,
                                              color: WeatherAppColor.whiteColor)
                                          .copyWith(
                                              fontSize: WeatherAppFontSize.s14),
                                    ),
                                    3.0.sizeHeight,
                                    Text(
                                      "${weatherModel.wind.speed} ${WeatherAppString.kmh}",
                                      style: WeatherAppFonts.large(
                                              fontWeight: FontWeight.w500,
                                              color: WeatherAppColor.whiteColor)
                                          .copyWith(
                                              fontSize: WeatherAppFontSize.s14),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image(
                                        image:
                                            Svg(WeatherAppResources.feelsLike)),
                                    3.0.sizeHeight,
                                    Text(
                                      WeatherAppString.feelsLike,
                                      style: WeatherAppFonts.large(
                                              fontWeight: FontWeight.w500,
                                              color: WeatherAppColor.whiteColor)
                                          .copyWith(
                                              fontSize: WeatherAppFontSize.s14),
                                    ),
                                    3.0.sizeHeight,
                                    Text(
                                      weatherModel.main.feelsLike
                                          .ceil()
                                          .toString(),
                                      style: WeatherAppFonts.large(
                                              fontWeight: FontWeight.w500,
                                              color: WeatherAppColor.whiteColor)
                                          .copyWith(
                                              fontSize: WeatherAppFontSize.s14),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              BlocBuilder<ForecastControllerBloc, ForecastControllerState>(
                  builder: (context, states) {
                if (states is ForecastLoaded) {
                  _saveForeCast(states.foreCastModel, context);
                  List<ListElement> data = [];
                  data.add(states.foreCastModel.list[0]);
                  data.add(states.foreCastModel.list[1]);
                  data.add(states.foreCastModel.list[2]);
                  data.add(states.foreCastModel.list[3]);
                  List<String> dayNext = WeatherHome.getNextFiveDays();
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: SizedBox(
                        height: 200.h,
                        child: GlassContainer(
                          color: WeatherAppColor.blackColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(data.length, (index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 7.w, right: 7.w, top: 20.h),
                                    child: NextWeekCard(
                                      daysOfWeek: dayNext[index],
                                      forecastModel: data[index],
                                      offline: false,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              })
            ],
          ),
        )
      ]);
    });
  }

  Widget setCelcius(state) {
    if (state is SetSettingFarenheit) {
      log(state.farenheit.toString());
      if (state.farenheit) {
        return RichText(
            text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: WeatherHome.farenHeit(weatherModel.main.temp).toString(),
            style: WeatherAppFonts.large(
                    fontWeight: FontWeight.w500,
                    color: WeatherAppColor.whiteColor)
                .copyWith(fontSize: WeatherAppFontSize.s48),
          ),
          WidgetSpan(
              child: Transform.translate(
                  offset: const Offset(2, -8),
                  child: Row(
                    children: [
                      Text(
                        WeatherAppString.farenheit,
                        style: WeatherAppFonts.large(
                                fontWeight: FontWeight.w700,
                                color: WeatherAppColor.whiteColor)
                            .copyWith(fontSize: WeatherAppFontSize.s24),
                      ),
                    ],
                  )))
        ]));
      } else {
        return RichText(
            text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: (weatherModel.main.temp.ceil()).toString(),
            style: WeatherAppFonts.large(
                    fontWeight: FontWeight.w500,
                    color: WeatherAppColor.whiteColor)
                .copyWith(fontSize: WeatherAppFontSize.s48),
          ),
          WidgetSpan(
              child: Transform.translate(
                  offset: const Offset(2, -8),
                  child: Row(
                    children: [
                      Text(
                        WeatherAppString.celcius,
                        style: WeatherAppFonts.large(
                                fontWeight: FontWeight.w700,
                                color: WeatherAppColor.whiteColor)
                            .copyWith(fontSize: WeatherAppFontSize.s24),
                      ),
                    ],
                  )))
        ]));
      }
    } else {
      return RichText(
          text: TextSpan(children: <InlineSpan>[
        TextSpan(
          text: (weatherModel.main.temp.ceil()).toString(),
          style: WeatherAppFonts.large(
                  fontWeight: FontWeight.w500,
                  color: WeatherAppColor.whiteColor)
              .copyWith(fontSize: WeatherAppFontSize.s48),
        ),
        WidgetSpan(
            child: Transform.translate(
                offset: const Offset(2, -8),
                child: Row(
                  children: [
                    Text(
                      WeatherAppString.celcius,
                      style: WeatherAppFonts.large(
                              fontWeight: FontWeight.w700,
                              color: WeatherAppColor.whiteColor)
                          .copyWith(fontSize: WeatherAppFontSize.s24),
                    ),
                  ],
                )))
      ]));
    }
  }

  void _saveForeCast(ForeCastModel foreCastModel, BuildContext context) {
    final userBloc = BlocProvider.of<SaveForeCastBloc>(context);
    userBloc.add(SaveForeCastData(foreCastModel));
  }

  void _getFavorite(BuildContext context) async {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(const GetFavoriteEvent());
  }

  void _saveFavorite(WeatherModel weatherModel, BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(FavoriteSaveEvent(weatherModel));
  }
}
