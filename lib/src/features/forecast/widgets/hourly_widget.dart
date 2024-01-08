import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/utils/custom_decoration.dart';
import '../../widgets/custom_temperature_widget.dart';

class HourlyWidget extends StatelessWidget {
  final bool isThisTime;

  const HourlyWidget({
    required this.isThisTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.18,
      height: size.height * 0.18,
      child: DecoratedBox(
        decoration: isThisTime ? CustomDecoration.customDecoration() : BoxDecoration(
          borderRadius:  const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: AppColors.white,
            width: 0.5,
          ),

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTemperature(
                text: "24",
                textSize: size.width * 0.06,
                temperatureSize: size.width * 0.03,
              ),
              SvgPicture.asset(
                AppImages.icBang,
              ),
              Text(
                "17:00",
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
