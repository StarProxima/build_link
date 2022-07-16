import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/util/app_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BarChart3 extends StatefulWidget {
  const BarChart3({
    Key? key,
  }) : super(key: key);

  static const shadowColor = Color(0xFFCCCCCC);
  static const dataList = [
    _BarData(1.13),
    _BarData(1.06),
    _BarData(1.03),
    _BarData(0.94),
    _BarData(0.91),
    _BarData(0.89),
    _BarData(0.84),
    _BarData(0.84),
    _BarData(0.82),
    _BarData(0.78),
  ];

  @override
  State<BarChart3> createState() => _BarChart3State();
}

class _BarChart3State extends State<BarChart3> {
  BarChartGroupData generateBarGroup(
    int x,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: touchedGroupIndex == x
              ? AppColors.text
              : AppColors.text.withOpacity(0.8),
          borderRadius: BorderRadius.zero,
          width: 12,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
        color: AppColors.text, fontSize: 10, fontWeight: FontWeight.bold);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${(value * 100).toInt() / 100} %';
    }
    return SideTitleWidget(
      angle: AppUtils().degreeToRadian(value < 0 ? 30 : -30),
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(
                        color: Color(0xFFececec),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBehindEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 47,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: _IconWidget(
                              [
                                'Павел',
                                'Игорь',
                                'Владислав',
                                'Михаил',
                                'Кирилл',
                                'Гиренка',
                                'Хахок',
                                'Виктор',
                                'Сергей',
                                'Александр',
                              ][index],
                              isSelected: touchedGroupIndex == index,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xFFececec),
                      dashArray: null,
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: BarChart3.dataList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(
                      index,

                      data.value,
                      //data.shadowValue,
                    );
                  }).toList(),
                  maxY: 1.2,
                  minY: 0.7,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipMargin: 0,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.toString(),
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: rod.color!,
                            fontSize: 18,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 12,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarData {
  final double value;

  const _BarData(
    this.value,
  );
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  final bool isSelected;
  final String name;
  const _IconWidget(
    this.name, {
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 200));

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 2 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.2;
    return Column(
      children: [
        Transform(
          transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
          origin: const Offset(14, 14),
          child: Column(
            children: [
              Icon(
                widget.isSelected ? Icons.face : Icons.face,
                color: widget.isSelected
                    ? AppColors.text
                    : AppColors.text.withOpacity(0.8),
                size: 26,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        widget.isSelected
            ? Text(
                widget.name,
                style: AppTextStyles.titleSmall.copyWith(fontSize: 10),
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>;
  }
}
