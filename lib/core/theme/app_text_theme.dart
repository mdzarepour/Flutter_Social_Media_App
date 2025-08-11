import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_connection/core/utils/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextStyle _poppins(
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) => GoogleFonts.poppins(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );

  static TextStyle _dmSans(
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) => GoogleFonts.dmSans(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: _poppins(30, AppColors.materialWhite, FontWeight.w900),
    headlineMedium: _dmSans(15, AppColors.materialWhite, FontWeight.w400),
    titleLarge: _dmSans(17, AppColors.materialWhite, FontWeight.w500),
    titleMedium: _dmSans(15, AppColors.materialGrey, FontWeight.w400),
    titleSmall: _dmSans(15, AppColors.materialGreen, FontWeight.w500),
    bodyLarge: _poppins(25, AppColors.materialWhite, FontWeight.w700),
    bodyMedium: _poppins(
      17,
      AppColors.materialBlack,
      FontWeight.w400,
    ).copyWith(color: AppColors.materialWhite),
    bodySmall: _dmSans(15, AppColors.materialPink, FontWeight.w500),
  );
}
