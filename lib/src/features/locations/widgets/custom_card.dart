import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/rectangle_const.dart';
import '../../widgets/custom_temperature_widget.dart';

class CustomCart extends StatelessWidget {
  final Size size;
  final String temperature;
  final String weather;
  final String country;

  const CustomCart({
    required this.temperature,
    required this.weather,
    required this.country,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            RectangleConst.rectangleOne,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTemperature(
                  text: temperature,
                  temperatureSize: 30,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textSize: 60,
                ),
                Text(
                  weather,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  country,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 1,
            right: size.width * 0.05,
            child: SvgPicture.asset(
              AppImages.icSun,
              width: size.width * 0.35,
            ),
          ),
        ],
      ),
    );
  }
}
