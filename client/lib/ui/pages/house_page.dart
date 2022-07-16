import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/ui/widgets/action_card_button.dart';
import 'package:flutter/gestures.dart';
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
      AppTextStyles.title.copyWith(fontWeight: FontWeight.w500, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      style: AppTextStyles.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Информация:",
                  style: AppTextStyles.titleMedium,
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
                      icon: const AppIcon(
                        AppIcons.rub,
                        size: 18,
                      ),
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
                  "Действия:",
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                },
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  ActionCardButton(
                    text: 'Запланировать посещение',
                    icon: AppIcon(
                      AppIcons.calendar,
                      color: AppColors.accent,
                    ),
                    onTap: () {},
                  ),
                  ActionCardButton(
                    text: 'Забронировать квартиру',
                    icon: AppIcon(
                      AppIcons.comment_check,
                      color: AppColors.accent,
                    ),
                    onTap: () {},
                  ),
                  ActionCardButton(
                    text: 'Добавить пользователю',
                    icon: AppIcon(
                      AppIcons.user_plus,
                      color: AppColors.accent,
                    ),
                    onTap: () {},
                  ),
                  ActionCardButton(
                    text: 'Сформировать презентацию',
                    icon: AppIcon(
                      AppIcons.image_alt,
                      color: AppColors.accent,
                    ),
                    onTap: () {},
                  ),
                  ActionCardButton(
                    text: 'Ипотечный калькулятор',
                    icon: AppIcon(
                      AppIcons.calendar,
                      color: AppColors.accent,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Text(
              "Фотографии:",
              style: AppTextStyles.titleMedium,
            ),
          ),
          SizedBox(
            height: 180,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                },
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: const [
                  HouseImageCard(
                    image: NetworkImage(
                      'https://zhiznsovkusom.ru/images/wp-content/uploads/image84-min-4.jpg',
                    ),
                  ),
                  HouseImageCard(
                    image: NetworkImage(
                      'https://zhiznsovkusom.ru/images/wp-content/uploads/image84-min-4.jpg',
                    ),
                  ),
                  HouseImageCard(
                    image: NetworkImage(
                      'https://zhiznsovkusom.ru/images/wp-content/uploads/image84-min-4.jpg',
                    ),
                  ),
                  HouseImageCard(
                    image: NetworkImage(
                      'https://zhiznsovkusom.ru/images/wp-content/uploads/image84-min-4.jpg',
                    ),
                  ),
                  HouseImageCard(
                    image: NetworkImage(
                      'https://zhiznsovkusom.ru/images/wp-content/uploads/image84-min-4.jpg',
                    ),
                  ),
                ],
              ),
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
          style: AppTextStyles.title.copyWith(color: AppColors.text),
        ),
      ],
    );
  }
}

class HouseImageCard extends StatelessWidget {
  const HouseImageCard({Key? key, required this.image}) : super(key: key);

  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
