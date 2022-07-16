import 'package:build_link/ui/widgets/charts/bar_chart1.dart';
import 'package:build_link/ui/widgets/charts/bar_chart2.dart';
import 'package:build_link/ui/widgets/charts/bar_chart3.dart';
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
      appBar: AppBar(
        title: const Text('Диаграммы'),
      ),
      body: ListView(
        children: const [
          BarChart1(),
          SizedBox(
            height: 16,
          ),
          BarChart2(),
          SizedBox(
            height: 16,
          ),
          BarChart3(),
        ],
      ),
    );
  }
}
