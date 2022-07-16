import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/icons.dart';
import 'package:flutter/material.dart';

class ActionCardButton extends StatelessWidget {
  const ActionCardButton(
      {Key? key, required this.text, required this.onTap, required this.icon})
      : super(key: key);

  final String text;
  final Widget icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 192,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: AppColors.divider,
        ),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: AppColors.accent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                text,
                style: AppTextStyles.titleSmall,
                textAlign: TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
