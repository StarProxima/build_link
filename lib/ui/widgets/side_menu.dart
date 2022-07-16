import 'package:build_link/data/app_styles.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key, required this.onChangePage}) : super(key: key);

  final Function(int) onChangePage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.white,
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
              onChangePage(0);
            },
          ),
          SideMenuButton(
            appIcon: AppIcons.calendar,
            label: 'Календарь',
            onTap: () {
              onChangePage(1);
            },
          ),
          SideMenuButton(
            appIcon: AppIcons.search,
            label: 'Поиск',
            onTap: () {
              onChangePage(2);
            },
          ),
        ],
      ),
    );
  }
}

class SideMenuButton extends StatelessWidget {
  const SideMenuButton(
      {Key? key,
      required this.onTap,
      required this.label,
      required this.appIcon})
      : super(key: key);

  final VoidCallback onTap;
  final String label;
  final AppIcons appIcon;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        primary: Colors.blueGrey,
        alignment: Alignment.centerLeft,
        shape: const RoundedRectangleBorder(),
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(double.infinity, 50),
      ),
      icon: AppIcon(
        appIcon,
        size: 30,
        color: Colors.blueGrey,
      ),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
