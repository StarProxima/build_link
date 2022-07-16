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
  }) : super(key: key);

  final Function(String) onEditiningComplite;
  final Function(String)? onChange;
  final Widget? trailing;
  final Widget? leading;
  final FocusNode? focus;
  final TextEditingController? controller;
  final String hintText;
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
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 16,
          right: 16,
          bottom: 10,
        ),
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          elevation: 5,
          child: TextField(
            controller: nameController,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            onChanged: widget.onChange,
            onTap: () => widget.onChange?.call(nameController.text),
            onEditingComplete: () => widget.onEditiningComplite(nameController.text),
            focusNode: focus,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: widget.hintText,
              prefixIcon: widget.leading ??
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  focus.hasFocus
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).textTheme.bodyText1!.color,
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
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                            )
                          : const SizedBox(),
                  widget.trailing ?? const SizedBox()
                ],
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
