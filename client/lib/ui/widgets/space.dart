import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double space;
  final Axis orientation;

  const Space({Key? key, required this.space, this.orientation = Axis.vertical}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: orientation == Axis.horizontal ? space : null,
      height: orientation == Axis.vertical ? space : null,
    );
  }
}
