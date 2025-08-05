import 'package:currency_app/config/constants/app_colors.dart';
import 'package:currency_app/config/theme/app_text_theme.dart';
import 'package:currency_app/config/theme/app_widget_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      surface: AppColors.materialSecondBlue,
      onSurface: AppColors.materialWhite,
      primary: AppColors.materialThirdBlue,
      onPrimary: AppColors.materialWhite,
      secondary: AppColors.materialThirdBlue,
      onSecondary: AppColors.materialWhite,
      primaryContainer: AppColors.materialGrey,
      onPrimaryContainer: AppColors.materialWhite,
      secondaryContainer: AppColors.materialSoftGreyWO,
    ),
    filledButtonTheme: AppWidgetTheme.filledButtonTheme,
    inputDecorationTheme: AppWidgetTheme.textFieldDarkTheme,
    textTheme: AppTextTheme.darkTextTheme,
    scaffoldBackgroundColor: AppColors.materialFirstBlue,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      surface: AppColors.materialWhite,
      onSurface: AppColors.materialBlack,
      primary: AppColors.materialSoftGreyWO,
      onPrimary: AppColors.materialBlack,
      secondary: AppColors.materialSoftGrey,
      onSecondary: AppColors.materialBlack,
      primaryContainer: AppColors.materialSoftGreyWO,
      onPrimaryContainer: AppColors.materialBlack,
      secondaryContainer: AppColors.materialSoftGreyWO,
    ),
    filledButtonTheme: AppWidgetTheme.filledButtonTheme,
    inputDecorationTheme: AppWidgetTheme.textFieldLightTheme,
    textTheme: AppTextTheme.lightTextTheme,
    scaffoldBackgroundColor: AppColors.materialWhite,
  );
}
