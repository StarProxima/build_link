import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/styles.dart';
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

  var usingBonus = false;
  var isButtonPressable = false;

  var discountController = TextEditingController();
  var benefitController = TextEditingController();

  var costController = TextEditingController();
  var firstContributionController = TextEditingController();
  var discountTermController = TextEditingController();
  var percentsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    costController.addListener(checkButtonEnabled);
    firstContributionController.addListener(checkButtonEnabled);
    discountTermController.addListener(checkButtonEnabled);
    percentsController.addListener(checkButtonEnabled);
  }

  void checkButtonEnabled() {
    setState(() {
      isButtonPressable = costController.text.isNotEmpty &&
          firstContributionController.text.isNotEmpty &&
          discountTermController.text.isNotEmpty &&
          percentsController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            height: 48,
            child: Row(
              children: [
                Text(
                  "Калькулятор",
                  style: AppTextStyles.titleLarge,
                ),
                Text(
                  " Кредита",
                  style: AppTextStyles.titleLarge
                      .copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  child: Container(
                    color: AppColors.background,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Входные данные:",
                              style: AppTextStyles.titleMedium
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        const Space(space: 16),
                        CustomTextField(
                          controller: costController,
                          label: "Стоимость жилья:",
                          suffix: "₽",
                        ),
                        const Space(space: 8),
                        CustomTextField(
                          controller: firstContributionController,
                          label: "Первонач. взнос:",
                          suffix: "₽",
                        ),
                        const Space(space: 8),
                        CustomTextField(
                          controller: discountTermController,
                          label: "Срок кредита:",
                          suffix: "мес",
                        ),
                        const Space(space: 8),
                        CustomTextField(
                          controller: percentsController,
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
                        CustomTextField(
                          controller: discountController,
                          label: "Размер скидки:",
                          suffix: "₽",
                        ),
                        const Space(space: 8),
                        CustomTextField(
                          controller: benefitController,
                          label: "Льготная ставка:",
                          suffix: "%",
                        ),
                        const Space(space: 8),
                        TextButton(
                            style: AppButtonStyle.cardButton,
                            onPressed: () {
                              if (isButtonPressable) {
                                setState(() {
                                  calculateCredit();
                                  usingBonus =
                                      benefitController.text.isNotEmpty ||
                                          discountController.text.isNotEmpty;

                                  calculated = true;
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 48,
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                color: isButtonPressable
                                    ? AppColors.text
                                    : AppColors.divider,
                                border: Border.all(
                                    color: AppColors.divider, width: 0),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Рассчитать",
                                  style: AppTextStyles.label.copyWith(
                                    fontSize: 16,
                                    color: isButtonPressable
                                        ? AppColors.background
                                        : AppColors.textDisable,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )),
                      ],
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Результаты:",
                              style: AppTextStyles.titleMedium
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        infoTable(),
                      ],
                    ),
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

  Widget infoTable() {
    return calculated
        ? Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(
                color: AppColors.divider,
                width: 1,
              ),
              color: AppColors.background,
            ),
            child: Row(
              children: !usingBonus
                  ? [
                      resultTitles(),
                      calculatedValues(),
                    ]
                  : [
                      resultTitles(),
                      calculatedValues(),
                      calculatedValuesWithBonus(),
                      benefitValues(),
                    ],
            ),
          )
        : const Spacer();
  }

  Widget resultTitles() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Название",
              style: AppTextStyles.label.copyWith(
                fontSize: 14,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Сумма кредита:",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Ежемесячный платеж:",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Начисленные проценты:",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Долг + проценты:",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget calculatedValues() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "Значение",
              style: AppTextStyles.label.copyWith(
                fontSize: 14,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "3.500.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "50.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "480.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "4.480.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget calculatedValuesWithBonus() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "C бонусом",
              style: AppTextStyles.label.copyWith(
                fontSize: 14,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "3.500.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "50.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "480.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "4.480.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget benefitValues() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "Выгода",
              style: AppTextStyles.label.copyWith(
                fontSize: 14,
                color: AppColors.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "3.500.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "50.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "480.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              "4.480.000",
              style: AppTextStyles.label
                  .copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
        ],
      ),
    );
  }
}
