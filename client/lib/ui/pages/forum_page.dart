import 'dart:math';
import 'package:build_link/data/model/event_model.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/widgets/search_panel.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

import '../../data/styles/icons.dart';

class ForumPage extends StatefulWidget {
  static const List<String> question = [
    "Подскажите, есть на сегодняшний день варианты продажи недвижимости нерезидентом (Болгария) своей квартиры в РФ?",
    "Что делать, если клиент постоянно переносит просмотр квартиры?",
    "На сколько правильно приходить на встречу с клиентом не в деловом костюме?"
  ];
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForumPageState();
}

class ForumPageState extends State<ForumPage> {
  @override
  void initState() {
    super.initState();
  }

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
                        "Обучение",
                        style: AppTextStyles.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Статьи",
                    style: AppTextStyles.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: AppColors.backgroundDark,
                            border: Border.all(color: AppColors.divider, width: 3),
                          ),
                          child: TextButton(
                            onPressed: (){},
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Text("Погружение в Build-Link" ,style: AppTextStyles.titleSmall,),
                                SizedBox(height: 4,),
                                Text("Как работать в приложении" ,style: AppTextStyles.label.copyWith(color: AppColors.text, decoration: TextDecoration.underline, fontWeight: FontWeight.w500, fontSize: 12),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: AppColors.backgroundDark,
                            border: Border.all(color: AppColors.divider, width: 3),
                          ),
                          child: TextButton(
                            
                            onPressed: (){},
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Text("Как рыба в воде" ,style: AppTextStyles.titleSmall ),
                                SizedBox(height: 4,),
                                Text("Разбор всей информации об объектах" ,style: AppTextStyles.label.copyWith(color: AppColors.text, decoration: TextDecoration.underline, fontWeight: FontWeight.w500, fontSize: 12),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: AppColors.backgroundDark,
                            border: Border.all(color: AppColors.divider, width: 3),
                          ),
                          child: TextButton(
                            onPressed: (){},
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Text("Точим языки" ,style: AppTextStyles.titleSmall),
                                SizedBox(height: 4,),
                                Text("Как продать объект клиенту" ,style: AppTextStyles.label.copyWith(color: AppColors.text, decoration: TextDecoration.underline, fontWeight: FontWeight.w500, fontSize: 12),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Форум",
                    style: AppTextStyles.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SearchPanel(
                    onEditiningComplite: (_) {},
                    isMap: false,
                  ),
                  // TextField(
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.search),
                  //   ),
                  //   onChanged: (value) {

                  //   },
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: const Color(0xFFE0E2F6)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Row(children: [
                              const SizedBox(
                                height: 32,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ForumPage.question[index],
                                      style: AppTextStyles.label.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.text),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Вопрос решён",
                                      style: AppTextStyles.title.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textDisable),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: ForumPage.question.length
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Text(
                        "Не нашли свой вопрос?\nСпросите его у экспертов:",
                        style: AppTextStyles.label.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(child: SizedBox(width: 8,)),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFFE0E2F6),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Задать вопрос",
                            style: AppTextStyles.titleMedium.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  
                    
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
