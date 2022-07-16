import 'package:build_link/data/styles/app_styles.dart';
import 'package:flutter/material.dart';

import '../../data/model/house_model.dart';
import '../../data/styles/colors.dart';
import '../../data/styles/fonts.dart';

class HousePage extends StatefulWidget {
  final House house;
  final int index;

  const HousePage({Key? key, required this.house, required this.index})
      : super(key: key);

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  final TextStyle textStyle =
      AppFontStyles.title.copyWith(fontWeight: FontWeight.w500, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const AppIcon(AppIcons.back),
                ),
                Text(
                  widget.house.name,
                  style: AppFontStyles.title.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: AppColors.text,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Информация:",
              style: AppFontStyles.title.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.text,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisExtent: 50,
              ),
              children: [
                HousePageField(
                  icon: const AppIcon(AppIcons.state),
                  text: widget.house.state == "f" ? 'Свободна' : 'Занята',
                ),
                HousePageField(
                  icon: const AppIcon(AppIcons.room_count),
                  text: widget.house.roomCount.toString() +
                      (widget.house.roomCount < 5
                          ? (widget.house.roomCount == 1
                              ? " комната"
                              : " комнаты")
                          : " комнат"),
                ),
                HousePageField(
                  icon: const AppIcon(AppIcons.diagonal_arrows),
                  text: "Площадь: ${widget.house.squareMeters} м^2",
                ),
                // HousePageField(
                //   icon: const AppIcon(AppIcons.state),
                //   text: widget.house.state == "f" ? 'Свободна' : 'Занята',
                // ),
                HousePageField(
                  icon: const AppIcon(AppIcons.vertical_arrows),
                  text: 'Высота потолков: ${widget.house.ceilingHeight} м',
                ),
                HousePageField(
                  icon: const AppIcon(AppIcons.state),
                  text: 'Цена: ${widget.house.cost} руб',
                ),
                HousePageField(
                  icon: const AppIcon(AppIcons.check),
                  text: widget.house.repair
                      ? "Сделан ремонт"
                      : "Ремонт не сделан",
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Фотографии квартиры:",
              style: AppFontStyles.title.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.text,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 164,
              child: Row(
                children: const [],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Действия:",
              style: AppFontStyles.title.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.text,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 106,
              child: Row(
                children: [
                  Container(
                    width: 164,
                    decoration: const BoxDecoration(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HousePageField extends StatelessWidget {
  const HousePageField({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: AppFontStyles.title.copyWith(color: AppColors.text),
        )
      ],
    );
  }
}
