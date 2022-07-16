import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../../data/model/house_model.dart';

class HousePage extends StatefulWidget {
  final HouseModel house;

  const HousePage({Key? key, required this.house}) : super(key: key) ;

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(24), 
    child: Container(
      color: Colors.blue,
      child: Column(
        children : [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: () => log("1"), icon: const Icon(Icons.arrow_left)),
              ),
              SizedBox(width: 12,),
              Text(widget.house.name, style: Theme.of(context).textTheme.headlineLarge,)
            ],
          ),
          SizedBox(height: 26,),
          Text("Информация", style: Theme.of(context).textTheme.headlineLarge,)
        ]
      ),
    )
    );
  }
}