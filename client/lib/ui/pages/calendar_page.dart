import 'dart:math';

import 'package:build_link/data/model/event_model.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/widgets/event_card.dart';
import 'package:build_link/ui/widgets/heatmap_calendar/heatmap_calendar.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

import '../../data/model/heatmap_color_mode.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMapCalendarExample();
}

class _HeatMapCalendarExample extends State<CalendarPage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heatLevelController = TextEditingController();

  bool isOpacityMode = true;
  DateTime choosedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Map<DateTime, int> heatMapDatasets = {};

  final eventList = [];

  @override
  void initState() {
    Random r = Random();
    DateTime now = DateTime.now();
    heatMapDatasets = {
      for (int i = 0; i < 100; i++)
        DateTime(
          now.year,
          now.month,
          1,
        ).add(
          Duration(days: i),
        ): r.nextInt(15)
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Column(
        children: [
          title,
          const Space(space: 16),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: double.infinity),
              child: MediaQuery.of(context).size.width < 950
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          calendar,
                          const Space(
                            space: 16,
                            orientation: Axis.vertical,
                          ),
                          eventsList,
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        calendar,
                        const Space(
                          space: 16,
                          orientation: Axis.horizontal,
                        ),
                        eventsList,
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get title {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Text(
            "Календарь",
            style: AppTextStyles.title.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const Spacer(),
          TextButton(
            style: AppButtonStyle.cardButton,
            onPressed: () {},
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                border: Border.all(color: AppColors.divider, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              height: 48,
              child: Text(
                "Добавить событие",
                style: AppTextStyles.label.copyWith(
                  color: AppColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get calendar {
    return Container(
      alignment: Alignment.topLeft,
      child: HeatMapCalendar(
        size: 48,
        monthFontSize: 16,
        fontSize: 16,
        weekFontSize: 16,
        colorMode: ColorMode.color,
        weekTextColor: AppColors.accent,
        selectedColor: AppColors.accent,
        borderRadius: 8,
        colorTipCount: 4,
        selectedTextColor: AppColors.background,
        textColor: AppColors.text,
        defaultColor: AppColors.background,
        colorsets: const {
          10: Color(0xFFB1BFF6),
          12: Color(0xFF97A8E8),
          13: Color(0xFF7B90DA),
          14: Color(0xFF667AC5),
        },
        selectedBorder: Border.all(width: 3, color: Colors.red),
        datasets: heatMapDatasets,
        onClick: (value) {
          choosedDay = DateTime(value.year, value.month, value.day);
          setState(() {});
        },
      ),
    );
  }

  Widget get eventsList {
    int count = heatMapDatasets[choosedDay]! <= 10
        ? 0
        : heatMapDatasets[choosedDay]! <= 12
            ? 1
            : heatMapDatasets[choosedDay]! <= 13
                ? 2
                : 3;
    Random ran = Random();
    Set<int> choosedTime = {};
    while (choosedTime.length < count) {
      choosedTime.add(ran.nextInt(24));
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 2000, maxWidth: 250),
      color: AppColors.background,
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Text(
                  "События на ",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  choosedDay.month == DateTime.now().month &&
                          choosedDay.day == DateTime.now().day
                      ? "Сегодня "
                      : "${choosedDay.month}:${choosedDay.day < 10 ? "0" : ""}${choosedDay.day}",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.accent,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 24,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: choosedTime.contains(index)
                      ? const Icon(
                          Icons.event_busy,
                          color: Colors.red,
                        )
                      : const Icon(Icons.crop_free, color: Colors.green),
                  title: Text(
                      choosedTime.contains(index)
                          ? "Показ квартиры"
                          : "Свободно",
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.text,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                  subtitle: Text(
                      index < 9
                          ? "0$index:00 - 0${index + 1}:00"
                          : index == 9
                              ? "0$index:00 - ${index + 1}:00"
                              : "$index:00 - ${index + 1}:00",
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.textDisable,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  onLongPress: () {},
                );
              },
              separatorBuilder: (context, index) {
                return const Space(space: 8);
              },
            ),
          )
        ],
      ),
    );
  }
}
