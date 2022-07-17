import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String suffix;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.suffix,
  }) : super(key: key);

  // padding: const EdgeInsets.only(left: 8, right: 8),
  //     height: 36,
  //     decoration: BoxDecoration(
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(8),
  //       ),
  //       color: AppColors.backgroundDark,
  //       border: Border.all(color: AppColors.divider, width: 1),
  //     ),
  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      inputFormatters: [ FilteringTextInputFormatter(RegExp(r"[1234567890.]"), allow: true)],
      cursorColor: AppColors.text,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        filled: true,

        fillColor: AppColors.backgroundDark,

        contentPadding: const EdgeInsets.all(8),
        prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textDisable,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        border: InputBorder.none,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            suffix,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textDisable,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        //suffixText: suffix,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.divider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.divider,
          ),
        ),
      ),
      style: AppTextStyles.label.copyWith(
        color: AppColors.text,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
