import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: AppButtonStyle.cardButton,
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          height: 132 + 24,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                height: 132,
                width: 184,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColors.divider, width: 1),
                  color: AppColors.backgroundDark,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2 км. кв., 45 кв. м.\nТаманская улица",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Space(space: 8),
                  cardLabel(
                    const AppIcon(AppIcons.state),
                    "test",
                  ),
                  cardLabel(
                    const AppIcon(AppIcons.rub),
                    "4.500.000р",
                  ),
                  cardLabel(
                    const AppIcon(AppIcons.state),
                    "test",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardLabel(AppIcon icon, String text) {
    return Container(
      color: AppColors.background,
      width: 128,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const Space(
            space: 12,
            orientation: Axis.horizontal,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.label.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
