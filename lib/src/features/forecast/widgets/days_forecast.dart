import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../widgets/custom_temperature_widget.dart';

class DaysForecast extends StatelessWidget {
  const DaysForecast({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sep, 12",
            style: context.textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SvgPicture.asset(
            AppImages.icBang,
          ),
          CustomTemperature(
            text: "24",
            textSize: size.width * 0.06,
            temperatureSize: size.width * 0.03,
          ),
        ],
      ),
    );
  }
}
