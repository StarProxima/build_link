import 'dart:math';

import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/widgets/calculator_input.dart';
import 'package:build_link/ui/widgets/calculator_result.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:build_link/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

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

  var discountController =
      MaskedTextController(mask: '000 000 000 000 000 000 000');
  var benefitController = TextEditingController();

  var costController =
      MaskedTextController(mask: '000 000 000 000 000 000 000');

  var firstContributionController =
      MaskedTextController(mask: '000 000 000 000 000 000 000');
  var discountTermController = TextEditingController();
  var percentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  " Ипотеки",
                  style: AppTextStyles.titleLarge
                      .copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.of(context).size.width < 950
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CalculatorInput(
                        calculateCredit: calculateCredit,
                        benefitController: benefitController,
                        costController: costController,
                        discountController: discountController,
                        discountTermController: discountTermController,
                        firstContributionController:
                            firstContributionController,
                        percentsController: percentsController,
                      ),
                      const Space(
                        space: 24,
                        orientation: Axis.vertical,
                      ),
                      calculated
                          ? Expanded(
                              child: Container(
                                color: AppColors.background,
                                child: CalucalorResult(
                                  creditSum: creditSum,
                                  mountPay: mountPay,
                                  procentSum: procentSum,
                                  procentAndCredit: procentAndCredit,
                                  usingBonus: usingBonus,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CalculatorInput(
                        calculateCredit: calculateCredit,
                        benefitController: benefitController,
                        costController: costController,
                        discountController: discountController,
                        discountTermController: discountTermController,
                        firstContributionController:
                            firstContributionController,
                        percentsController: percentsController,
                      ),
                      const Space(
                        space: 24,
                        orientation: Axis.horizontal,
                      ),
                      calculated
                          ? Expanded(
                              child: Container(
                                color: AppColors.background,
                                child: CalucalorResult(
                                  creditSum: creditSum,
                                  mountPay: mountPay,
                                  procentSum: procentSum,
                                  procentAndCredit: procentAndCredit,
                                  usingBonus: usingBonus,
                                ),
                              ),
                            )
                          : const SizedBox(),
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

  bool calculateCredit(bool usingBonus) {
    procentAndCredit = [];
    procentSum = [];
    mountPay = [];
    creditSum = [];

    creditSum.add(
      double.parse(costController.text.replaceAll(' ', '')) -
          double.parse(firstContributionController.text.replaceAll(' ', '')),
    );
    mountPay.add(calculatePay(
        double.parse(costController.text.replaceAll(' ', '')),
        int.parse(discountTermController.text),
        double.parse(percentsController.text)));
    procentSum.add(
      roundDouble(
        mountPay[0] * int.parse(discountTermController.text) - creditSum[0],
        2,
      ),
    );
    procentAndCredit.add(procentSum[0] + creditSum[0]);

    if (usingBonus) {
      double discount = discountController.text
                  .replaceAll(' ', '')
                  .isNotEmpty &&
              double.tryParse(discountController.text.replaceAll(' ', '')) !=
                  null
          ? double.parse(discountController.text.replaceAll(' ', ''))
          : 0;
      double benefit = benefitController.text.isNotEmpty &&
              double.tryParse(benefitController.text) != null
          ? double.parse(benefitController.text)
          : -1;

      creditSum.add(double.parse(costController.text.replaceAll(' ', '')) -
          double.parse(firstContributionController.text.replaceAll(' ', '')) -
          discount);
      if (benefit != -1) {
        mountPay.add(calculatePay(
            double.parse(costController.text.replaceAll(' ', '')) - discount,
            int.parse(discountTermController.text),
            benefit));
      } else {
        mountPay.add(
          calculatePay(
            double.parse(costController.text.replaceAll(' ', '')) - discount,
            int.parse(discountTermController.text),
            double.parse(percentsController.text),
          ),
        );
      }
      procentSum.add(
        roundDouble(
          mountPay[1] * int.parse(discountTermController.text) - creditSum[1],
          2,
        ),
      );
      procentAndCredit.add(procentSum[1] + creditSum[1]);

      procentAndCredit
          .add(roundDouble(procentAndCredit[0] - procentAndCredit[1], 2));
      mountPay.add(roundDouble(mountPay[0] - mountPay[1], 2));
      procentSum.add(roundDouble(procentSum[0] - procentSum[1], 2));
      creditSum.add(roundDouble(creditSum[0] - creditSum[1], 2));
    }
    setState(() {
      this.usingBonus = usingBonus;
      calculated = true;
    });

    return true;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  double calculatePay(double credit, int mounts, double procent) {
    procent /= 100;
    procent /= 12;
    num tmp = pow((1 + procent), mounts);
    return roundDouble(credit * ((procent) * tmp) / (tmp - 1), 2);
  }
}
