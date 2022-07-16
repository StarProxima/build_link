import 'package:build_link/model/client_model.dart';
import 'package:build_link/styles/colors.dart';
import 'package:build_link/styles/fonts.dart';
import 'package:build_link/styles/styles.dart';
import 'package:build_link/ui/space.dart';
import 'package:flutter/material.dart';

class ClientCardWidget extends StatelessWidget {
  final ClientModel client;
  final Function onPress;

  const ClientCardWidget({
    Key? key,
    required this.client,
    required this.onPress,
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
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              offset: Offset.zero,
              blurRadius: 24,
            )
          ]),
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
            const Space(space: 6),
            cardInfo,
            const Space(space: 8),
            Divider(height: 1, color: AppColors.divider),
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
            style: AppFontStyles.title.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
              fontSize: 20,
            ),
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
          cardLabel(client.phoneNumber),
          const Space(
            space: 6,
          ),
          cardLabel(client.note),
          const Space(
            space: 6,
          ),
          cardLabel(client.state),
        ],
      ),
    );
  }

  Widget cardLabel(String text) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Text(
            text,
            style: AppFontStyles.label.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textDisable,
            ),
          ),
        ],
      ),
    );
  }

  Widget get homeStatus {
    return Container(
      height: 40,
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
            "Нет квартир",
            style: AppFontStyles.label.copyWith(
              fontSize: 12,
              color: AppColors.textDisable,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
