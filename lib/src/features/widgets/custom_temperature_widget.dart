import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';

class CustomTemperature extends StatelessWidget {
  final String text;
  final double? textSize;
  final double? temperatureSize;
  final MainAxisAlignment? mainAxisAlignment;

  const CustomTemperature({
    required this.text,
    this.textSize = 100,
    this.temperatureSize = 45,
    this.mainAxisAlignment = MainAxisAlignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment!,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: AppColors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "℃",
          style: TextStyle(
            fontSize: temperatureSize,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
