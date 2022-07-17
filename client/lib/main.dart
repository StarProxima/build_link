import 'dart:io';

import 'package:build_link/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'data/styles/colors.dart';
import 'package:desktop_window/desktop_window.dart';

void main() {
  //if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {}
  runApp(const MyApp());
}

Future testWindowFunctions() async {
  await DesktopWindow.setMinWindowSize(const Size(900, 400));
  await DesktopWindow.setMaxWindowSize(const Size(4000, 4000));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    testWindowFunctions();
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
