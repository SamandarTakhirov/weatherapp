import 'package:flutter/material.dart';
import 'package:weatherapp/src/common/utils/context_utils.dart';

import '../../../common/constants/app_colors.dart';

class CustomAddButton extends StatelessWidget {
  final Size size;
  final void Function() onTap;

  const CustomAddButton({
    required this.onTap,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          BackButton(
            color: AppColors.textColor,
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              fixedSize: Size(
                size.width * 0.85,
                size.height * 0.07,
              ),
              backgroundColor: AppColors.white,
              alignment: Alignment.centerLeft,
            ),
            onPressed: onTap,
            child: Text(
              "Add New Location",
              textAlign: TextAlign.start,
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
