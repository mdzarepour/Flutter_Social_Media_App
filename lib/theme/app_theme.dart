import 'package:flutter/material.dart';
import 'package:social_connection/utils/app_colors.dart';
import 'package:social_connection/theme/app_text_theme.dart';
import 'package:social_connection/theme/app_widget_theme.dart';

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
}
