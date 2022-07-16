import 'package:build_link/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
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
