import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';

class AppGradiants {
  AppGradiants._();

  static const LinearGradient primaryGradiant = LinearGradient(
    colors: [AppColors.color1, AppColors.color3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradiant = LinearGradient(
    colors: [AppColors.color5, AppColors.color1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.0, 0.8], // Define the position of each color stop
  );
}
