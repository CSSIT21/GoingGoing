import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    headline2: GoogleFonts.montserrat(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    headline3: GoogleFonts.montserrat(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    bodyText1: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    bodyText2: GoogleFonts.montserrat(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    subtitle1: GoogleFonts.montserrat(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    subtitle2: GoogleFonts.montserrat(
      fontSize: 14.0,
      color: AppColors.grey3,
    ),
    headline4:GoogleFonts.montserrat(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
  );
}
