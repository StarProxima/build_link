import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/widgets/charts/bar_chart1.dart';
import 'package:build_link/ui/widgets/charts/bar_chart2.dart';
import 'package:build_link/ui/widgets/charts/bar_chart3.dart';
import 'package:build_link/ui/widgets/charts/bar_chart4.dart';
import 'package:build_link/ui/widgets/charts/bar_chart5.dart';
import 'package:build_link/ui/widgets/custom_scroll_controller.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: CustumScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Статистика",
                  style: AppTextStyles.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              'Топ агентов по коммисии',
              style: AppTextStyles.titleSmall,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
                child: const BarChart1(),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              'Топ агентов по среднему чеку',
              style: AppTextStyles.titleSmall,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
                child: const BarChart2(),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              'Топ агентов по конверсии (CR)',
              style: AppTextStyles.titleSmall,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
                child: const BarChart3(),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              'Топ агентов по кол-ву сделок',
              style: AppTextStyles.titleSmall,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
                child: const BarChart4(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
