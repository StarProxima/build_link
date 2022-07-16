import 'package:build_link/data/styles/colors.dart';
import 'package:flutter/material.dart';

extension AppTextStyles on TextStyle {
  static TextStyle title = TextStyle(
    fontFamily: "Montserrat",
    color: AppColors.text,
    height: 1.115,
  );

  static TextStyle titleLarge = TextStyle(
    fontFamily: "Montserrat",
    height: 1.115,
    fontSize: 32,
    color: AppColors.text,
    fontWeight: FontWeight.w800,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: "Montserrat",
    height: 1.115,
    fontSize: 24,
    color: AppColors.text,
    fontWeight: FontWeight.w700,
  );

  static TextStyle label = const TextStyle(
    fontFamily: "Overpass",
  );
}
