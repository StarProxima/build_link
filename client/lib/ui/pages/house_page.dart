import 'package:flutter/material.dart';

import '../../model/house_model.dart';

class HousePage extends StatefulWidget {
  final HouseModel house;

  const HousePage({Key? key, required this.house}) : super(key: key);

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [],
      ),
    ]);
  }
}
