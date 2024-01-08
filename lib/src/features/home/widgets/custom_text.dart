import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';

import '../../../common/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  final String customIcon;
  final String mainText;
  final String text;

  const CustomText({
    required this.customIcon,
    required this.mainText,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(customIcon),
              Text(
                mainText,
                style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 17,
          width: 1.5,
          child: ColoredBox(
            color: AppColors.white,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
