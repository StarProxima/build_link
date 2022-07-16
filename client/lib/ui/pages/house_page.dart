import 'package:flutter/material.dart';

import '../../data/model/house_model.dart';
import '../../data/styles/colors.dart';
import '../../data/styles/fonts.dart';

class HousePage extends StatefulWidget {
  final HouseModel house;
  final int index;

  const HousePage({Key? key, required this.house, required this.index}) : super(key: key);

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  final TextStyle textStyle = AppFontStyles.title.copyWith(fontWeight: FontWeight.w500, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_left)),
                  width: 48,
                  height: 44,
                ),
                SizedBox(
                    height: 48,
                    child: Text(
                      widget.house.name,
                      style: AppFontStyles.title
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 32, color: AppColors.text),
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 48,
                child: Text(
                  "Информация:",
                  style: AppFontStyles.title.copyWith(fontWeight: FontWeight.w700, fontSize: 24, color: AppColors.text),
                )),
            SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.arrow_left)),
                          SizedBox(
                            width: 8,
                          ),
                          widget.house.state == "f"
                              ? Text("Свободна", style: textStyle.copyWith(color: Color(0xFF1C9819)))
                              : Text("Занята", style: textStyle.copyWith(color: Color.fromARGB(255, 205, 20, 17)))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.arrow_left)),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                              widget.house.roomCount.toString() +
                                  (widget.house.roomCount < 5
                                      ? (widget.house.roomCount == 1 ? " комната" : " комнаты")
                                      : " комнат"),
                              style: textStyle.copyWith(color: AppColors.text))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.arrow_left)),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Площадь: " + widget.house.squareMeters.toString() + " м^2",
                              style: textStyle.copyWith(color: AppColors.text))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.arrow_left)),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Высота потолков: " + widget.house.ceilingHeight.toString() + " м",
                              style: textStyle.copyWith(color: AppColors.text))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.arrow_left)),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Цена: " + widget.house.cost.toString() + " руб",
                              style: textStyle.copyWith(color: AppColors.text))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: 32, height: 32, child: Icon(Icons.arrow_left)),
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.house.repair ? "Сделан ремонт" : "Ремонт не сделан",
                              style: textStyle.copyWith(color: AppColors.text))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 48,
                child: Text(
                  "Фотографии квартиры:",
                  style: AppFontStyles.title.copyWith(fontWeight: FontWeight.w700, fontSize: 24, color: AppColors.text),
                )),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 164,
              child: Row(
                children: [],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 48,
                child: Text(
                  "Действия:",
                  style: AppFontStyles.title.copyWith(fontWeight: FontWeight.w700, fontSize: 24, color: AppColors.text),
                )),
            SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 106,
                child: Row(
                  children: [
                    Container(
                      width: 164,
                      decoration: BoxDecoration(),
                    )
                  ],
                ))
          ])),
    );
  }
}
