import 'package:flutter/cupertino.dart';

abstract class CustomGradient {
  static LinearGradient customGradient() => const LinearGradient(
        colors: [
          Color(0xFF47BFDF),
          Color(0xFF4A91FF),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
