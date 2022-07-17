import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: AppColors.backgroundDark,
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Expanded(
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: AppColors.textDisable,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Space(
              space: 16,
              orientation: Axis.horizontal,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  suffixText: suffix,
                  suffixStyle: AppTextStyles.label.copyWith(
                    color: AppColors.textDisable,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.right,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
