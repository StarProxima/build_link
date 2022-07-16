// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class AppImages {
  static AssetImage userpin = const AssetImage('assets/images/userpin.png');
}

class AppIcon extends StatelessWidget {
  const AppIcon(AppIcons icon, {Key? key, this.color, this.size})
      : _icon = icon,
        super(key: key);
  final Color? color;
  final AppIcons _icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/${_icon.name}.svg",
      width: size ?? 20,
      height: size ?? 20,
      color: color,
    );
  }
}

enum AppIcons {
  mydeal,
  calendar,
  search,
  icon,
  build_link,
  next,
  phone,
  state,
  back,
  info,
}
