import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get _base => GoogleFonts.plusJakartaSans();

  // Headings
  static TextStyle headingBlack = _base.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.slate900,
    letterSpacing: -0.5,
    height: 1.15,
  );

  static TextStyle headingXL = _base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.slate900,
    letterSpacing: -0.5,
  );

  static TextStyle headingLG = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.slate900,
    letterSpacing: -0.3,
  );

  static TextStyle headingMD = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.slate900,
  );

  // Body
  static TextStyle bodyLG = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.slate400,
  );

  static TextStyle bodySM = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.slate700,
  );

  static TextStyle bodyXS = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.slate400,
  );

  // Labels
  static TextStyle labelUppercase = _base.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w900,
    color: AppColors.slate400,
    letterSpacing: 2.5,
  );

  static TextStyle labelSM = _base.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.slate400,
    letterSpacing: 1.0,
  );

  // Button
  static TextStyle buttonLG = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  // Chip / Tag
  static TextStyle tag = _base.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w900,
    color: AppColors.slate900,
    letterSpacing: 0.5,
  );
}
