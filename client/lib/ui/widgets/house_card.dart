import 'package:build_link/data/styles/colors.dart';
import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        children: [
          Container(
            height: 154,
            width: 232,
            color: AppColors.backgroundDark,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
