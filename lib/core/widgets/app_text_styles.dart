import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextStyles{
  static const heading = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static const title = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static const subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.subHeading,
  );

  static const subheadingA1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.subHeading,
  );

  static const small = TextStyle(
    fontSize: 14,
    color: AppColors.subHeading,
  );
}