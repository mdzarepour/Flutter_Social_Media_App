import 'package:flutter/material.dart';
import 'package:social_connection/core/utils/app_colors.dart';
import 'package:social_connection/core/theme/app_text_theme.dart';

class AppWidgetTheme {
  AppWidgetTheme._();

  static FilledButtonThemeData filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  static InputDecorationTheme textFieldDarkTheme = InputDecorationTheme(
    prefixIconColor: AppColors.materialWhite,
    hintStyle: AppTextTheme.darkTextTheme.titleMedium,
    filled: true,
    fillColor: AppColors.materialThirdBlue,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.materialWhite),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.materialWhite),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.materialWhite),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
