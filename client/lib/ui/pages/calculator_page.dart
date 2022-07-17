import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:build_link/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  final int? initialCost;

  const CalculatorPage({Key? key, required this.initialCost}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var calculated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 48,
            child: Row(
              children: [
                Text(
                  "Калькулятор",
                  style: AppTextStyles.titleLarge,
                ),
                Text(
                  " Кредита",
                  style: AppTextStyles.titleLarge.copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  child: Expanded(
                    child: Container(
                      color: AppColors.background,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Входные данные:",
                                style: AppTextStyles.titleMedium.copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                          const Space(space: 16),
                          const CustomTextField(
                            controller: null,
                            label: "Стоимость жиилья:",
                            suffix: "₽",
                          ),
                          const Space(space: 8),
                          const CustomTextField(
                            controller: null,
                            label: "Первонач. взнос:",
                            suffix: "₽",
                          ),
                          const Space(space: 8),
                          const CustomTextField(
                            controller: null,
                            label: "Срок кредита:",
                            suffix: "мес",
                          ),
                          const Space(space: 8),
                          const CustomTextField(
                            controller: null,
                            label: "Процентная ставка:",
                            suffix: "%",
                          ),
                          const Space(space: 16),
                          Row(
                            children: [
                              Text(
                                "Скидки и льготы:",
                                style: AppTextStyles.titleMedium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Space(space: 16),
                          const CustomTextField(
                            controller: null,
                            label: "Размер скидки:",
                            suffix: "₽",
                          ),
                          const Space(space: 8),
                          const CustomTextField(
                            controller: null,
                            label: "Льготная ставка:",
                            suffix: "%",
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  calculateCredit();
                                  calculated = true;
                                });
                              },
                              child: const Text(
                                "Рассчитать",
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Space(
                  space: 24,
                  orientation: Axis.horizontal,
                ),
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    child: resultInfo(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  calculateCredit() {
    //TODO: calculate
  }

  Widget resultInfo() {
    return calculated
        ? Column(
            children: [
              Row(
                children: [
                  Text(
                    "Результат:",
                    style: AppTextStyles.titleMedium.copyWith(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 220,
                    child: Expanded(
                        child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(
                            "",
                            style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(
                            "Сумма кредита:",
                            style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(
                            "Ежемесячный платеж:",
                            style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(
                            "Начисленные проценты:",
                            style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(
                            "Долг + проценты:",
                            style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                          ),
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: Text(
                          "Значение",
                          style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: Text(
                          "С бонусами",
                          style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: Text(
                          "Значение",
                          style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ],
          )
        : const Spacer();
  }
}
