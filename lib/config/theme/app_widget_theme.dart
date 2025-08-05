import 'package:currency_app/config/constants/app_colors.dart';
import 'package:currency_app/config/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

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

  static InputDecorationTheme textFieldLightTheme = InputDecorationTheme(
    prefixIconColor: AppColors.materialBlack,
    hintStyle: AppTextTheme.lightTextTheme.titleMedium,
    filled: true,
    fillColor: AppColors.materialSoftGrey,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.materialBlack),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.materialBlack),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.materialBlack),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
