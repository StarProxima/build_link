import 'package:build_link/styles/colors.dart';
import 'package:flutter/material.dart';

extension AppButtonStyle on ButtonStyle {
  static ButtonStyle cardButton = ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
  );
}
