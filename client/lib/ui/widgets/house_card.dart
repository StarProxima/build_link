import 'package:build_link/data/model/house_model.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget {
  final House house;
  final Function onPress;
  const HouseCard({Key? key, required this.house, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: AppButtonStyle.cardButton,
      onPressed: () {
        onPress();
      },
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
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: AppColors.background,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(house.planUrl.toString()),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    house.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Space(space: 8),
                  cardLabel(
                    const AppIcon(
                      AppIcons.state,
                      size: 20,
                    ),
                    house.state,
                  ),
                  cardLabel(
                    const AppIcon(
                      AppIcons.rub,
                      size: 20,
                    ),
                    house.cost.toString(),
                  ),
                  cardLabel(
                    const AppIcon(
                      AppIcons.check,
                      size: 20,
                    ),
                    house.address,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardLabel(AppIcon icon, String text) {
    return SizedBox(
      height: 24,
      child: Container(
        alignment: Alignment.topLeft,
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            const Space(
              space: 8,
              orientation: Axis.horizontal,
            ),
            Flexible(
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
      ),
    );
  }
}
