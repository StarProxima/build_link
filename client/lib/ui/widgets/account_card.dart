import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/icons.dart';
import 'package:flutter/material.dart';

import 'space.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({Key? key, required this.name, required this.role})
      : super(key: key);

  final String name;
  final String role;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: AppColors.backgroundDark,
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: const AppIcon(
            AppIcons.user,
          ),
        ),
        const Space(
          space: 8,
          orientation: Axis.horizontal,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.label.copyWith(
                color: AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              role,
              style: AppTextStyles.label.copyWith(
                color: AppColors.textDisable,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
