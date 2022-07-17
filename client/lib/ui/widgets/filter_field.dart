import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/data/styles/fonts.dart';
import 'package:build_link/ui/widgets/space.dart';
import 'package:flutter/material.dart';

class FilterField extends StatefulWidget {
  final String title;
  final Function(String, String) onValuesChange;

  const FilterField({Key? key, required this.title, required this.onValuesChange}) : super(key: key);

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  final fromFieldController = TextEditingController();
  final toFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
