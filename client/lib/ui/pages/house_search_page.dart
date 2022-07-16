import 'package:build_link/data/model/house_model.dart';
import 'package:build_link/data/repositories/house_repository.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/pages/house_page.dart';
import 'package:build_link/ui/widgets/filter_field.dart';
import 'package:build_link/ui/widgets/house_card.dart';
import 'package:build_link/ui/widgets/house_tag_card.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

class HouseSearchPage extends StatefulWidget {
  const HouseSearchPage({Key? key}) : super(key: key);

  @override
  State<HouseSearchPage> createState() => _HouseSearchPageState();
}

class _HouseSearchPageState extends State<HouseSearchPage> {
  List<House> findedHouses = [];

  final ScrollController cardsController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HouseRepository.searchHouses().then((value) {
      setState(() {
        findedHouses = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Поиск квартир",
                style: AppTextStyles.titleLarge,
              ),
              const Spacer(),
            ],
          ),
          const Space(space: 32),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 420, minHeight: double.infinity),
                    color: AppColors.background,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Фильтры",
                                  style: AppTextStyles.titleLarge.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  style: AppButtonStyle.cardButton,
                                  onPressed: () {
                                    //action
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                    alignment: Alignment.center,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: AppColors.backgroundDark,
                                      border: Border.all(color: AppColors.divider, width: 1),
                                    ),
                                    child: Text(
                                      "Применить",
                                      style: AppTextStyles.titleLarge.copyWith(
                                        fontSize: 12,
                                        color: AppColors.accent,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Space(space: 16),
                          FilterField(
                            title: "Цена",
                            onValuesChange: (_, __) {},
                          ),
                          FilterField(
                            title: "Площадь",
                            onValuesChange: (_, __) {},
                          ),
                          FilterField(
                            title: "Кол-во квартир",
                            onValuesChange: (_, __) {},
                          ),
                          FilterField(
                            title: "Этаж",
                            onValuesChange: (_, __) {},
                          ),
                          const Space(space: 24),
                          Row(
                            children: [
                              Text(
                                "Теги",
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          const Space(space: 8),
                          Wrap(
                            alignment: WrapAlignment.start,
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
                        ],
                      ),
                    ),
                  ),
                  const Space(
                    space: 16,
                    orientation: Axis.horizontal,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              Text(
                                "Результаты поиска:",
                                style: AppTextStyles.titleLarge.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Space(
                          space: 16,
                          orientation: Axis.vertical,
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: ((context, constraints) {
                              return ListView.separated(
                                controller: cardsController,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return HouseCard(
                                    house: findedHouses[index],
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) {
                                            return HousePage(
                                              house: findedHouses[index],
                                            );
                                          },
                                          transitionsBuilder: (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            const begin = Offset(0.0, 1.0);
                                            const end = Offset.zero;
                                            final tween =
                                                Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOut));
                                            final offsetAnimation = animation.drive(tween);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );

                                            //return child;
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Space(space: 8);
                                },
                                itemCount: findedHouses.length,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
