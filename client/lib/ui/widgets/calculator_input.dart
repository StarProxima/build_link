import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/data/styles/styles.dart';
import 'package:build_link/ui/widgets/custom_text_field.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CalculatorInput extends StatefulWidget {
  const CalculatorInput({
    Key? key,
    required this.calculateCredit,
    required this.discountController,
    required this.benefitController,
    required this.costController,
    required this.firstContributionController,
    required this.discountTermController,
    required this.percentsController,
  }) : super(key: key);

  final bool Function(bool) calculateCredit;

  final TextEditingController discountController;
  final TextEditingController benefitController;
  final TextEditingController costController;
  final TextEditingController firstContributionController;
  final TextEditingController discountTermController;
  final TextEditingController percentsController;

  @override
  State<CalculatorInput> createState() => _CalculatorInputState();
}

class _CalculatorInputState extends State<CalculatorInput> {
  var calculated = false;

  bool usingBonus = false;
  var isButtonPressable = false;

  void checkButtonEnabled() {
    setState(() {
      isButtonPressable =
          widget.costController.text.replaceAll(' ', '').isNotEmpty &&
              double.tryParse(widget.costController.text.replaceAll(' ', '')) !=
                  null &&
              widget.firstContributionController.text
                  .replaceAll(' ', '')
                  .isNotEmpty &&
              double.tryParse(widget.firstContributionController.text
                      .replaceAll(' ', '')) !=
                  null &&
              widget.discountTermController.text.isNotEmpty &&
              int.tryParse(widget.discountTermController.text) != null &&
              widget.percentsController.text.isNotEmpty &&
              double.tryParse(widget.percentsController.text) != null;
    });
  }

  @override
  void initState() {
    widget.costController.addListener(checkButtonEnabled);
    widget.firstContributionController.addListener(checkButtonEnabled);
    widget.discountTermController.addListener(checkButtonEnabled);
    widget.percentsController.addListener(checkButtonEnabled);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Входные данные",
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
            const Space(space: 16),
            CustomTextField(
              controller: widget.costController,
              label: "Стоимость жилья:",
              suffix: "₽",
            ),
            const Space(space: 8),
            CustomTextField(
              controller: widget.firstContributionController,
              label: "Первонач. взнос:",
              suffix: "₽",
            ),
            const Space(space: 8),
            CustomTextField(
              controller: widget.discountTermController,
              label: "Срок кредита:",
              suffix: "мес",
            ),
            const Space(space: 8),
            CustomTextField(
              controller: widget.percentsController,
              label: "Процентная ставка:",
              suffix: "%",
            ),
            const Space(space: 16),
            Row(
              children: [
                Text(
                  "Скидки и льготы",
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
            const Space(space: 16),
            CustomTextField(
              controller: widget.discountController,
              label: "Размер скидки:",
              suffix: "₽",
            ),
            const Space(space: 8),
            CustomTextField(
              controller: widget.benefitController,
              label: "Льготная ставка:",
              suffix: "%",
            ),
            const Space(space: 8),
            TextButton(
              style: AppButtonStyle.cardButton,
              onPressed: () {
                if (isButtonPressable) {
                  setState(() {
                    usingBonus = (widget.benefitController.text.isNotEmpty &&
                            double.tryParse(widget.benefitController.text) !=
                                null) ||
                        (widget.discountController.text
                                .replaceAll(' ', '')
                                .isNotEmpty &&
                            double.tryParse(
                                  widget.discountController.text
                                      .replaceAll(' ', ''),
                                ) !=
                                null);
                    calculated = widget.calculateCredit(usingBonus);
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
                    color: isButtonPressable
                        ? AppColors.background
                        : AppColors.textDisable,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
