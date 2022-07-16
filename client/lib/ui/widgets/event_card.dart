import 'package:build_link/data/model/event_model.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider, width: 1),
        color: AppColors.background,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset.zero,
          )
        ],
      ),
      child: Row(
        children: [
          AppIcon(
            AppIcons.mydeal,
            size: 24,
            color: AppColors.text,
          ),
          const Space(
            space: 12,
            orientation: Axis.horizontal,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${event.getFrom()} - ${event.getTo()}",
                  style: AppTextStyles.label.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDisable,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
