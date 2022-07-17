import 'package:build_link/data/styles/colors.dart';
import 'package:flutter/material.dart';

class SearchPanel extends StatefulWidget implements PreferredSizeWidget {
  const SearchPanel({
    Key? key,
    required this.onEditiningComplite,
    this.trailing,
    this.leading,
    this.controller,
    this.focus,
    this.onChange,
    this.hintText = 'Поиск',
    required this.isMap,
  }) : super(key: key);

  final Function(String) onEditiningComplite;
  final Function(String)? onChange;
  final Widget? trailing;
  final Widget? leading;
  final FocusNode? focus;
  final TextEditingController? controller;
  final String hintText;
  final bool isMap;
  @override
  State<SearchPanel> createState() => _SearchPanelState();

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}

class _SearchPanelState extends State<SearchPanel> {
  late final FocusNode focus;

  late final TextEditingController nameController;

  bool onHover = false;

  @override
  void initState() {
    nameController = widget.controller ?? TextEditingController();
    focus = widget.focus ?? FocusNode()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: true,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        elevation: widget.isMap ? 5 : 0,
        child: TextField(
          controller: nameController,
          textInputAction: TextInputAction.search,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          onChanged: widget.onChange,
          onTap: () => widget.onChange?.call(nameController.text),
          onEditingComplete: () =>
              widget.onEditiningComplite(nameController.text),
          focusNode: focus,
          cursorColor: AppColors.text,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                widget.isMap ? AppColors.background : AppColors.backgroundDark,
            hintText: widget.hintText,
            prefixIcon: widget.leading ??
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: AppColors.text,
                  ),
                ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                focus.hasFocus
                    ? IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.text,
                        ),
                        onPressed: () {
                          focus.unfocus();
                          if (nameController.text.isNotEmpty) {
                            nameController.clear();
                            widget.onEditiningComplite(nameController.text);
                          }
                        },
                      )
                    : widget.leading != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.search,
                              color: AppColors.text,
                            ),
                          )
                        : const SizedBox(),
                widget.trailing ?? const SizedBox()
              ],
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: widget.isMap
                  ? const BorderSide(width: 0, color: Colors.transparent)
                  : BorderSide(
                      width: 1.5,
                      color: AppColors.divider,
                    ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: widget.isMap
                  ? const BorderSide(width: 0, color: Colors.transparent)
                  : BorderSide(
                      width: 1.5,
                      color: AppColors.divider,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
