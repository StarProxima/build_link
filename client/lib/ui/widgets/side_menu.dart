import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:flutter/material.dart';

import '../../data/styles/app_styles.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.onChangePage}) : super(key: key);

  final Function(int) onChangePage;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: const [
                AppIcon(
                  AppIcons.icon,
                  size: 36,
                ),
                SizedBox(
                  width: 10,
                ),
                AppIcon(AppIcons.build_link),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SideMenuButton(
            appIcon: AppIcons.mydeal,
            label: 'Мои заказы',
            onTap: () {
              selectedPageIndex = 0;
              widget.onChangePage(0);
            },
            isSelected: selectedPageIndex == 0,
          ),
          SideMenuButton(
            appIcon: AppIcons.calendar,
            label: 'Календарь',
            onTap: () {
              selectedPageIndex = 1;
              widget.onChangePage(1);
            },
            isSelected: selectedPageIndex == 1,
          ),
          SideMenuButton(
            appIcon: AppIcons.search,
            label: 'Поиск',
            onTap: () {
              selectedPageIndex = 2;
              widget.onChangePage(2);
            },
            isSelected: selectedPageIndex == 2,
          ),
        ],
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  const SideMenuButton({
    Key? key,
    required this.onTap,
    required this.label,
    required this.appIcon,
    required this.isSelected,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final AppIcons appIcon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.backgroundDark : AppColors.background,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        clipBehavior: Clip.antiAlias,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            primary: isSelected ? AppColors.accent : AppColors.text,
            textStyle: AppFontStyles.label.copyWith(
              color: isSelected ? AppColors.accent : AppColors.text,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            alignment: Alignment.centerLeft,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.all(16),
            minimumSize: const Size(double.infinity, 50),
          ),
          icon: AppIcon(
            appIcon,
            size: 20,
            color: isSelected ? AppColors.accent : AppColors.text,
          ),
          label: Text(label),
          onPressed: onTap,
        ),
      ),
    );
  }
}
