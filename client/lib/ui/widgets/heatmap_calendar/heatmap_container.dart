
import 'package:flutter/material.dart';

import '../../../data/model/heatmap_color.dart';

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? heatColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final bool? showText;
  final DateTime? selectedDate;
  final Function(DateTime dateTime)? onClick;
  final Border? selectedBorder;

  const HeatMapContainer({
    Key? key,
    required this.date,
    this.margin,
    this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.heatColor,
    this.textColor,
    this.onClick,
    this.selectedDate,
    this.showText,
    this.selectedColor,
    this.selectedTextColor,
    this.selectedBorder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapColor.defaultColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: selectedDate == date ? selectedBorder : null,
              color: selectedDate == date ? selectedColor : heatColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
            child: (showText ?? true)
                ? Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: selectedDate == date ? selectedTextColor : textColor ?? const Color(0xFF8A8A8A),
                      fontSize: fontSize,
                    ),
                  )
                : null,
          ),
        ),
        onTap: () {
          onClick != null ? onClick!(date) : null;
        },
      ),
    );
  }
}
