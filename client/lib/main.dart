import 'package:build_link/data/model/house_model.dart';
import 'package:build_link/data/repositories/house_repository.dart';
import 'package:build_link/ui/pages/house_page.dart';
import 'package:build_link/ui/pages/main_page.dart';
import 'package:build_link/ui/widgets/client_card_widget.dart';
import 'package:flutter/material.dart';
import 'data/model/client_model.dart';
import 'data/styles/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          splashColor: AppColors.backgroundDark,
          hoverColor: AppColors.backgroundDark,
        ),
      ),
      home: const MyHomePage(title: "важно"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  HouseModel? houseModel;
  void getSearchProducts()  {

    HouseRepository.getHouse().then((value) {
      setState(() {
        houseModel = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget child;
    if (houseModel == null) {
      child = TextButton(onPressed: () {
              if (houseModel == null) {
                getSearchProducts();
              } else {
                setState(() {
                  
                });
              }
            }, child: Text("1"));
    } else {
      child = HousePage(house: houseModel!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: child
    );
  }
}


            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: ClientCardWidget(
            //     client: ClientModel(
            //         0,
            //         0,
            //         "Хахук",
            //         "Рустам",
            //         "Нальбиевич",
            //         "8-918-226-04-47",
            //         "Текст\nочень длинный\nтекст dasd a asd da da sada as dasd asdasdasd dadasdasda dsadsadasdas",
            //         "Подписание договора"),
            //     onPress: () {},
            //   ),
            // ),