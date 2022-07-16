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
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.blueGrey,
              shape: const RoundedRectangleBorder(),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const AppIcon(
              AppIcons.mydeal,
              size: 30,
              color: Colors.blueGrey,
            ),
            label: const Text('Мои заказы'),
            onPressed: () {
              onChangePage(0);
            },
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.blueGrey,
              alignment: Alignment.centerLeft,
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.all(16),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const AppIcon(
              AppIcons.calendar,
              size: 30,
              color: Colors.blueGrey,
            ),
            label: const Text('Календарь'),
            onPressed: () {
              onChangePage(1);
            },
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.blueGrey,
              alignment: Alignment.centerLeft,
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.all(16),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const AppIcon(
              AppIcons.search,
              size: 30,
              color: Colors.blueGrey,
            ),
            label: const Text('Поиск'),
            onPressed: () {
              onChangePage(2);
            },
          ),
        ],
      ),
    );
  }
}
