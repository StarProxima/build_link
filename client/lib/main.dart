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
      home: const MainPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClientCardWidget(
                client: ClientModel(
                    0,
                    0,
                    "Хахук",
                    "Рустам",
                    "Нальбиевич",
                    "8-918-226-04-47",
                    "Текст\nочень длинный\nтекст dasd a asd da da sada as dasd asdasdasd dadasdasda dsadsadasdas",
                    "Подписание договора"),
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
