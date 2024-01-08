import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_images.dart';
import '../../common/constants/custom_gradient.dart';
import '../../common/models/weather_model.dart';
import '../../common/utils/custom_decoration.dart';
import '../forecast/forecast_page.dart';
import '../locations/locations_page.dart';
import '../map/map_page.dart';
import '../widgets/custom_temperature_widget.dart';
import 'bloc/weather_bloc_bloc.dart';
import 'widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  final WeatherModel? weatherModel;

  const HomePage({
    this.weatherModel,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final PageController _pageLoadController;

  @override
  void initState() {
    if (widget.weatherModel != null) {
      context.read<WeatherBlocBloc>().add(
            AddLocationEvent(
              widget.weatherModel!,
            ),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        return state.map(
          onWeatherBlocLoading: (state) => SizedBox(),
          onWeatherBlocFailure: (state) => SizedBox(),
          onWeatherBlocSuccess: (state) => Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationsPage(),
                    ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.location,
                  color: AppColors.white,
                ),
              ),
              centerTitle: true,
              title: Text(
                "${state.weather.areaName}",
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.add_circled,
                    color: AppColors.white,
                  ),
                )
              ],
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
            ),
            body: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                gradient: CustomGradient.customGradient(),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            AppImages.icLineVR,
                          ),
                          SvgPicture.asset(
                            AppImages.icLineHR,
                          ),
                        ],
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        left: size.width * 0.2,
                        child: Image.asset(
                          AppImages.img1,
                          width: size.width * 0.6,
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.05,
                    ),
                    child: SizedBox(
                      width: size.width * 0.85,
                      height: size.height * 0.4,
                      child: DecoratedBox(
                        decoration: CustomDecoration.customDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                DateFormat('EEEE, DD MMMM')
                                    .format(state.weather.date!),
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              CustomTemperature(
                                text:
                                    "${state.weather.temperature!.celsius!.round()}",
                              ),
                              Text(
                                "${state.weather.weatherMain}",
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "${(state.weather.windSpeed! * 1.609344).roundToDouble()}km/h",
                                    mainText: "Wind",
                                    customIcon: AppImages.icWindy,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomText(
                                    text: "${state.weather.humidity}%",
                                    mainText: "Hum",
                                    customIcon: AppImages.icHum,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: Size(
                        size.width * 0.7,
                        size.height * 0.065,
                      ),
                      elevation: 15,
                      backgroundColor: AppColors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForecastPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Forecast report",
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
