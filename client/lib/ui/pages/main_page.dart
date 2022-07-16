import 'package:build_link/data/model/house_model.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/ui/pages/calendar_page.dart';
import 'package:build_link/ui/pages/clients_page.dart';
import 'package:build_link/ui/pages/house_page.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/house_repository.dart';
import '../widgets/side_menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          const ClientsPage(agentID: 1),
          HousePage(
            house: House(
              address: 'Erngworu fweofhw',
              ceilingHeight: 2.7,
              cost: 3500000,
              description: "",
              housing_complex : "Вишняки",
              max_date : "2026-08-08",
              min_date : "2024-08-08",
              repair: true,
              roomCount: 3,
              squareMeters: 48,
              state: 'FEWf',
            ),
            index: index,
          ),
          const CalendarPage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: selectedIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          SideMenu(
            onChangePage: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Container(
            width: 1,
            color: AppColors.divider,
          ),
          Expanded(
            child: Stack(
              children: [
                _buildOffstageNavigator(0),
                _buildOffstageNavigator(1),
                _buildOffstageNavigator(2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
