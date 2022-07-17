import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterField extends StatefulWidget {
  final String title;
  final String? initFrom;
  final String? initTo;
  final Function(String, String) onValuesChange;

  const FilterField({
    Key? key,
    required this.title,
    required this.onValuesChange,
    this.initFrom,
    this.initTo,
  }) : super(key: key);

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  late TextEditingController fromFieldController;
  late TextEditingController toFieldController;

  @override
  void initState() {
    fromFieldController = TextEditingController(
      text: double.parse(widget.initFrom ?? "-1") == -1 ? "" : widget.initFrom,
    );
    toFieldController = TextEditingController(
      text: double.parse(widget.initTo ?? "-1") == -1 ? "" : widget.initTo,
    );
    fromFieldController.addListener(() {
      widget.onValuesChange(fromFieldController.text, toFieldController.text);
    });
    toFieldController.addListener(() {
      widget.onValuesChange(fromFieldController.text, toFieldController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fromFieldController = TextEditingController(
      text: double.parse(widget.initFrom ?? "-1") == -1 ? "" : widget.initFrom,
    );
    toFieldController = TextEditingController(
      text: double.parse(widget.initTo ?? "-1") == -1 ? "" : widget.initTo,
    );
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 24,
          child: Row(
            children: [
              Text(
                widget.title,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: AppColors.backgroundDark,
            border: Border.all(width: 1, color: AppColors.divider),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "От:",
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textDisable,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Space(
                        space: 8,
                        orientation: Axis.horizontal,
                      ),
                      Expanded(
                        child: Container(
                          height: 36,
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minWidth: double.infinity),
                          child: TextField(
                            inputFormatters: [FilteringTextInputFormatter(RegExp(r"[1234567890.]"), allow: true)],
                            controller: fromFieldController,
                            style: AppTextStyles.title
                                .copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                color: AppColors.divider,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "До:",
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textDisable,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Space(
                        space: 8,
                        orientation: Axis.horizontal,
                      ),
                      Expanded(
                        child: Container(
                          height: 36,
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minWidth: double.infinity),
                          child: TextField(
                            inputFormatters: [FilteringTextInputFormatter(RegExp(r"[1234567890.]"), allow: true)],
                            controller: toFieldController,
                            style: AppTextStyles.title
                                .copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
