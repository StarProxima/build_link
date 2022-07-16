import 'package:build_link/data/model/house_model.dart';
import 'package:build_link/data/repositories/house_repository.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
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
              constraints: const BoxConstraints(
                  minWidth: double.infinity, minHeight: double.infinity),
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                        maxWidth: 420, minHeight: double.infinity),
                    color: AppColors.background,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Фильтры",
                                style: AppTextStyles.titleMedium,
                              ),
                            ],
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
                    child: LayoutBuilder(
                      builder: ((context, constraints) {
                        return ListView.separated(
                          controller: cardsController,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return HouseCard();
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
          ),
        ],
      ),
    );
  }
}
