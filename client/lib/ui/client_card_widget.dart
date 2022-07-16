import 'package:build_link/model/client_model.dart';
import 'package:build_link/styles/colors.dart';
import 'package:build_link/styles/fonts.dart';
import 'package:build_link/ui/space.dart';
import 'package:flutter/material.dart';

class ClientCardWidget extends StatelessWidget {
  final ClientModel client;

  const ClientCardWidget({
    Key? key,
    required this.client,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        //action
      },
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(
            color: AppColors.divider,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
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
          Row(
            children: [
              Text(
                client.phoneNumber,
                style: AppFontStyles.label.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              )
            ],
          ),
          const Space(
            space: 6,
          ),
          Row(
            children: [
              Text(
                client.note,
                style: AppFontStyles.label.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              )
            ],
          ),
          const Space(
            space: 6,
          ),
          Row(
            children: [
              Text(
                client.state,
                style: AppFontStyles.label.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              )
            ],
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
