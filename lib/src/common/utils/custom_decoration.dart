import 'package:flutter/cupertino.dart';

import '../constants/app_colors.dart';

abstract class CustomDecoration {
  static BoxDecoration customDecoration() => BoxDecoration(
        borderRadius:  const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: AppColors.white,
        ),
        gradient: const RadialGradient(
          colors: [
            Color(0xB3FFFFFF),
            Color(0x80BFBFBF),
          ],
        ),
      );
}
