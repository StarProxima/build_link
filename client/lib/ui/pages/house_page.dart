import 'package:build_link/data/styles/icons.dart';
import 'package:build_link/ui/pages/map_page.dart';
import 'package:build_link/ui/widgets/action_card_button.dart';
import 'package:build_link/ui/widgets/mini_map.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:build_link/ui/widgets/house_tag_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../data/model/house_model.dart';
import '../../data/styles/colors.dart';
import '../../data/styles/fonts.dart';

class HousePage extends StatefulWidget {
  final House house;

  const HousePage({Key? key, required this.house}) : super(key: key);

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  final TextStyle textStyle =
      AppTextStyles.title.copyWith(fontWeight: FontWeight.w500, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const AppIcon(
                          AppIcons.back,
                          size: 32,
                        ),
                      ),
                      Text(
                        widget.house.title,
                        style: AppTextStyles.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Информация",
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 280,
                      mainAxisExtent: 40,
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
                        text:
                            'Высота потолков: ${widget.house.ceilingHeight} м',
                      ),
                      HousePageField(
                        icon: const AppIcon(
                          AppIcons.rub,
                          size: 18,
                        ),
                        text: 'Цена: ${widget.house.cost} руб',
                      ),
                      HousePageField(
                        icon:  AppIcon(
                          AppIcons.town,
                          size: 18,
                          color: AppColors.accent
                        ),
                        text: 'ЖК: ${widget.house.housingComplex}',
                      ),
                      HousePageField(
                        icon: AppIcon(
                          AppIcons.calendar,
                          size: 18,
                          color: AppColors.accent,
                        ),
                        text: 'Сдача: ${widget.house.dateRange}',
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
                    height: 16,
                  ),
                  Text(
                    "Теги",
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      HouseTagCard('Вид на море'),
                      HouseTagCard('Рядом аптека'),
                      HouseTagCard('Подземная парковка'),
                      HouseTagCard('Рядом детский сад'),
                      HouseTagCard('Большая детская площадка'),
                      HouseTagCard('Парковая зона'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Действия",
                    style: AppTextStyles.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 108,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                  },
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ActionCardButton(
                      text: 'Запланировать посещение',
                      icon: AppIcon(
                        AppIcons.calendar,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    const Space(space: 8, orientation: Axis.horizontal),
                    ActionCardButton(
                      text: 'Забронировать квартиру',
                      icon: AppIcon(
                        AppIcons.comment_check,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    const Space(space: 8, orientation: Axis.horizontal),
                    ActionCardButton(
                      text: 'Добавить пользователю',
                      icon: AppIcon(
                        AppIcons.user_plus,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    const Space(space: 8, orientation: Axis.horizontal),
                    ActionCardButton(
                      text: 'Сформировать презентацию',
                      icon: AppIcon(
                        AppIcons.image_alt,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    const Space(space: 8, orientation: Axis.horizontal),
                    ActionCardButton(
                      text: 'Ипотечный калькулятор',
                      icon: AppIcon(
                        AppIcons.calendar,
                        color: AppColors.accent,
                        size: 24,
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
                "Фотографии",
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
                child: ListView.separated(
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const HouseImageCard(
                      image: NetworkImage(
                        'https://artvaro.ru/wp-content/uploads/2018/04/e7b36a530d3e8db7sDeZSeceJ6iJFWyi-e1523916146357.jpg',
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Space(
                      space: 8,
                    );
                  },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Расположение",
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const AppIcon(
                        AppIcons.pin,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.house.address,
                        style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 250,
                    child: MiniMap(
                      coord: LatLng(45, 48),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            settings: RouteSettings(),
                            builder: (context) {
                              return MapPage(
                                initialPosition: LatLng(45, 48),
                                isFullScreen: true,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
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
