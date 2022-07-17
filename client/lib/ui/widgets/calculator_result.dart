import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalucalorResult extends StatefulWidget {
  const CalucalorResult({
    Key? key,
    required this.creditSum,
    required this.mountPay,
    required this.procentSum,
    required this.procentAndCredit,
    required this.usingBonus,
  }) : super(key: key);

  final List<double> creditSum;
  final List<double> mountPay;
  final List<double> procentSum;
  final List<double> procentAndCredit;

  final bool usingBonus;
  @override
  State<CalucalorResult> createState() => _CalucalorResultState();
}

class _CalucalorResultState extends State<CalucalorResult> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Результат',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(
            height: 12,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: SizedBox(
              child: GridView(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 50,
                ),
                children: [
                  CalculatorField(
                    text: 'Сумма кредита',
                    value: widget.creditSum[0],
                  ),
                  CalculatorField(
                    text: 'Начисленные проценты',
                    value: widget.procentSum[0],
                  ),
                  CalculatorField(
                    text: 'Ежемесячный платеж',
                    value: widget.mountPay[0],
                  ),
                  CalculatorField(
                    text: 'Итого',
                    value: widget.procentAndCredit[0],
                  ),
                ],
              ),
            ),
          ),
          widget.usingBonus
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'С учётом скидок и льгот',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      child: SizedBox(
                        child: GridView(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 50,
                          ),
                          children: [
                            CalculatorField(
                              text: 'Сумма кредита',
                              value: widget.creditSum[1],
                            ),
                            CalculatorField(
                              text: 'Начисленные проценты',
                              value: widget.procentSum[1],
                            ),
                            CalculatorField(
                              text: 'Ежемесячный платеж',
                              value: widget.mountPay[1],
                            ),
                            CalculatorField(
                              text: 'Итого',
                              value: widget.procentAndCredit[1],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Выгода',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      child: SizedBox(
                        child: GridView(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 50,
                          ),
                          children: [
                            CalculatorField(
                              color: AppColors.appGreen,
                              text: 'Сумма кредита',
                              value: widget.creditSum[2],
                            ),
                            CalculatorField(
                              color: AppColors.appGreen,
                              text: 'Начисленные проценты',
                              value: widget.procentSum[2],
                            ),
                            CalculatorField(
                              color: AppColors.appGreen,
                              text: 'Ежемесячный платеж',
                              value: widget.mountPay[2],
                            ),
                            CalculatorField(
                              color: AppColors.appGreen,
                              text: 'Итого',
                              value: widget.procentAndCredit[2],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

final NumberFormat priceFormater = NumberFormat.currency(
  locale: 'ru_RU',
  symbol: '₽',
  decimalDigits: 0,
);

class CalculatorField extends StatelessWidget {
  const CalculatorField({
    Key? key,
    required this.text,
    required this.value,
    this.color,
  }) : super(key: key);

  final String text;
  final double value;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.textDisable,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          priceFormater.format(value),
          style: AppTextStyles.titleSmall.copyWith(
            color: color ?? AppColors.accent,
          ),
        ),
      ],
    );
  }
}
