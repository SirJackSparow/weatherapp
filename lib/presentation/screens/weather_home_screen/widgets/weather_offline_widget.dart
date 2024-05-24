import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapps/const/app_extentions.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/setting_theme_util.dart';
import 'package:weatherapps/presentation/controllers/settings_theme_controller/settings_theme_bloc.dart';
import 'package:weatherapps/presentation/screens/weather_home_screen/widgets/reusable_container.dart';

import '../../../../const/app_color.dart';
import '../../../../const/appresources.dart';
import '../../../../const/utils/utils.dart';
import '../../../../const/utils/weather_app_fonts.dart';
import '../../../../const/utils/weather_app_string.dart';
import '../../../../const/utils/weather_font_sizes.dart';
import '../../../../const/utils/weather_paddings.dart';
import '../../../../data/entity/forecast_entity.dart';
import '../../../../data/entity/weather_entity.dart';
import '../../../commonwidgets/weather_app_bar.dart';
import '../../../controllers/forecast_get_local_controller/get_forecast_local_bloc.dart';
import '../../../controllers/weather_home_controller/weather_home_util.dart';

class WeatherOfflineWidget extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherOfflineWidget({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsThemeBloc,SettingsThemeState>(
      builder: (context,state) {
        return Stack(
          children: [
            SettingThemeUtil.backGround(state),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: WeatherAppBar(
                    cityNames: weatherModel.name,
                    onTap: () {})),
            Padding(padding: EdgeInsets.only(top: 70.h),
               child: ListView(
                 children: [
                   Padding(padding: const EdgeInsets.all(WeatherAppPaddings.s10),
                   child: GlassContainer(
                     color: WeatherAppColor.blackColor.withOpacity(0.3),
                     borderRadius: BorderRadius.circular(16),
                     child: Column(
                       children: [
                         3.0.sizeHeight,
                         Center(
                             child: Text(
                               HomeUtils.today(),
                               style: WeatherAppFonts.large(
                                   fontWeight: FontWeight.w400,
                                   color: WeatherAppColor.whiteColor)
                                   .copyWith(fontSize: WeatherAppFontSize.s30),
                             )),
                         2.0.sizeHeight,
                         Center(
                             child: Text(
                               HomeUtils.formatDateTime(
                                   weatherModel.updatedAt.toIso8601String()),
                               style: WeatherAppFonts.large(
                                   fontWeight: FontWeight.w300,
                                   color:
                                   WeatherAppColor.whiteColor.withOpacity(0.75))
                                   .copyWith(
                                 fontSize: WeatherAppFontSize.s16,
                               ),
                             )),

                         Column(
                           children: [
                             10.0.sizeHeight,
                             const Icon(Icons.sunny_snowing,size: 100.0,color: Colors.yellow,),
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
                                 RichText(
                                     text: TextSpan(children: <InlineSpan>[
                                       TextSpan(
                                         text:
                                         (weatherModel.main.temp.ceil()).toString(),
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
                                                         color: WeatherAppColor
                                                             .whiteColor)
                                                         .copyWith(
                                                         fontSize:
                                                         WeatherAppFontSize.s24),
                                                   ),
                                                 ],
                                               )))
                                     ])),
                                 Text(
                                   WeatherAppString.slash,
                                   style: WeatherAppFonts.large(
                                       fontWeight: FontWeight.w500,
                                       color: WeatherAppColor.whiteColor)
                                       .copyWith(fontSize: WeatherAppFontSize.s48),
                                 ),
                                 RichText(
                                     text: TextSpan(children: <InlineSpan>[
                                       TextSpan(
                                         text:
                                         (((9 / 5) * weatherModel.main.temp).ceil() +
                                             32)
                                             .toString(),
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
                                                         color: WeatherAppColor
                                                             .whiteColor)
                                                         .copyWith(
                                                         fontSize:
                                                         WeatherAppFontSize.s24),
                                                   ),
                                                 ],
                                               )))
                                     ]))
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     children: [
                                       Image(
                                           image:
                                           Svg(WeatherAppResources.humidtyIcon)),
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
                                           image: Svg(WeatherAppResources.windIcon)),
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

                   BlocBuilder<GetForeCastBloc,GetForeCastState>(builder: (context,states) {
                     if(states is GetForeCastLoaded) {
                       List<ListElement> data = [];
                       data.add(states.foreCastModel.list[0]);
                       data.add(states.foreCastModel.list[1]);
                       data.add(states.foreCastModel.list[2]);
                       data.add(states.foreCastModel.list[3]);
                       List<String> dayNext = HomeUtils.getNextFiveDays();
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
                                             offline: true,
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
          ],
        );
      }
    );
  }
}
