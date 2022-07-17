import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

import '../../data/model/client_model.dart';
import '../../data/styles/colors.dart';
import '../../data/styles/fonts.dart';
import '../../data/styles/styles.dart';

class ClientCardWidget extends StatelessWidget {
  final Client client;
  final Function onPress;
  final Function onHousesPress;

  const ClientCardWidget({
    Key? key,
    required this.client,
    required this.onPress,
    required this.onHousesPress,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: TextButton(
        style: AppButtonStyle.cardButton,
        onPressed: () {
          onPress();
        },
        child: Column(
          children: [
            const Space(
              space: 16,
            ),
            cardTitle,
            const Space(space: 8),
            cardInfo,
            const Space(space: 8),
            Container(
              height: 1,
              color: AppColors.divider,
            ),
            homeStatus
          ],
        ),
      ),
    );
  }

  Widget get cardTitle {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      height: 24,
      child: Row(
        children: [
          Text(
            "${client.firstName} ${client.lastName}",
            style: AppTextStyles.title.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const AppIcon(
            AppIcons.next,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget get cardInfo {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          cardLabel(
            const AppIcon(
              AppIcons.phone,
              size: 20,
            ),
            client.phoneNumber,
          ),
          const Space(
            space: 6,
          ),
          cardLabel(
            const AppIcon(
              AppIcons.info,
              size: 20,
            ),
            client.note,
          ),
          const Space(
            space: 6,
          ),
          cardLabel(
            const AppIcon(
              AppIcons.state,
              size: 20,
            ),
            client.state,
          ),
        ],
      ),
    );
  }

  Widget cardLabel(AppIcon icon, String text) {
    return SizedBox(
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

  Widget get homeStatus {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: double.infinity),
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: AppColors.backgroundDark,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Text(
              "Квартиры не выбраны",
              style: AppTextStyles.label.copyWith(
                fontSize: 12,
                color: AppColors.textDisable,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  onHousesPress();
                },
                child: Text(
                  "Подобрать",
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
