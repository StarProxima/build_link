import 'dart:math';

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
      isButtonPressable = costController.text.isNotEmpty && double.tryParse(costController.text) != null &&
          firstContributionController.text.isNotEmpty && double.tryParse(firstContributionController.text) != null &&
          discountTermController.text.isNotEmpty && int.tryParse(discountTermController.text) != null &&
          percentsController.text.isNotEmpty && double.tryParse(percentsController.text) != null;
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
                                    usingBonus =
                                        (benefitController.text.isNotEmpty && double.tryParse(benefitController.text) != null) ||
                                         (discountController.text.isNotEmpty && double.tryParse(discountController.text) != null);
                                    calculated = calculateCredit();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 48,
                                constraints: const BoxConstraints(minWidth: double.infinity),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  color: isButtonPressable ? AppColors.text : AppColors.divider,
                                  border: Border.all(color: AppColors.divider, width: 0),
                                ),
                                child: Text(
                                  "Рассчитать",
                                  style: AppTextStyles.label.copyWith(
                                    fontSize: 16,
                                    color: isButtonPressable ? AppColors.background : AppColors.textDisable,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )),
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Результаты:",
                              style: AppTextStyles.titleMedium.copyWith(fontSize: 20),
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

  List<double> creditSum = [];
  List<double> mountPay = [];
  List<double> procentSum = [];
  List<double> procentAndCredit = [];

  bool calculateCredit() {
    procentAndCredit = [];
    procentSum = [];
    mountPay = [];
    creditSum = [];

    creditSum.add(double.parse(costController.text) - double.parse(firstContributionController.text));
    mountPay.add(calculatePay(double.parse(costController.text), int.parse(discountTermController.text), double.parse(percentsController.text)));
    procentSum.add(roundDouble(mountPay[0]*int.parse(discountTermController.text)-creditSum[0],2));
    procentAndCredit.add(procentSum[0]+creditSum[0]);

    if (usingBonus) {
      double discount = discountController.text.isNotEmpty && double.tryParse(discountController.text) != null ? double.parse(discountController.text) : 0;
      double benefit = benefitController.text.isNotEmpty && double.tryParse(benefitController.text) != null ? double.parse(benefitController.text) : -1;
      
      creditSum.add(double.parse(costController.text) - double.parse(firstContributionController.text) - discount);
      if (benefit != -1) {
        mountPay.add(calculatePay(double.parse(costController.text)-discount, int.parse(discountTermController.text), benefit));
      } else {
        mountPay.add(calculatePay(double.parse(costController.text)-discount, int.parse(discountTermController.text), double.parse(percentsController.text)));
      }
      procentSum.add(roundDouble(mountPay[1]*int.parse(discountTermController.text)-creditSum[1],2));
      procentAndCredit.add(procentSum[1]+creditSum[1]);

      procentAndCredit.add(roundDouble(procentAndCredit[0]-procentAndCredit[1],2));
      mountPay.add(roundDouble(mountPay[0]-mountPay[1],2));
      procentSum.add(roundDouble(procentSum[0]-procentSum[1],2));
      creditSum.add(roundDouble(creditSum[0]-creditSum[1],2));
    }
    return true;
  }
  double roundDouble(double value, int places){ 
   num mod = pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
  }

  double calculatePay(double credit, int mounts, double procent) {
    procent /=100; procent/=12;
    num tmp = pow((1+procent),mounts);
    return roundDouble(credit* ((procent) * tmp)/(tmp-1), 2);
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
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Ежемесячный платеж:",
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Начисленные проценты:",
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              "Долг + проценты:",
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.text),
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
              creditSum[0].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              mountPay[0].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              procentSum[0].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              procentAndCredit[0].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
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
              creditSum[1].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              mountPay[1].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              procentSum[1].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              procentAndCredit[1].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.accent),
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
              creditSum[2].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              mountPay[2].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              procentSum[2].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 48,
            child: Text(
              procentAndCredit[2].toString(),
              style: AppTextStyles.label.copyWith(fontSize: 14, color: AppColors.appGreen),
            ),
          ),
        ],
      ),
    );
  }
}
