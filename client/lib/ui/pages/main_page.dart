import 'package:build_link/data/model/filters_inherit.dart';
import 'package:build_link/data/model/house_model.dart';
import 'package:build_link/data/repositories/house_repository.dart';
import 'package:build_link/data/styles/colors.dart';
import 'package:build_link/ui/pages/calculator_page.dart';
import 'package:build_link/ui/pages/calendar_page.dart';
import 'package:build_link/ui/pages/charts_page.dart';
import 'package:build_link/ui/pages/clients_page.dart';
import 'package:build_link/ui/pages/forum_page.dart';
import 'package:build_link/ui/pages/house_page.dart';
import 'package:build_link/ui/pages/house_search_page.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../widgets/side_menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  FiltersModel filters = FiltersModel()..initValue(square: Range(20, 30));
  GlobalKey<HouseSearchPageState> keyForSearch = GlobalKey<HouseSearchPageState>();
  GlobalKey<SideMenuState> sideMenu = GlobalKey<SideMenuState>();

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          ClientsPage(agentID: 1, goToSearch:() 
            { setState(() {
              selectedIndex = 3;
              keyForSearch.currentState!.makeSearch();
              sideMenu.currentState!.changeSelected(3);
            }
          ); 
          },),
          const CalendarPage(),
          const ForumPage(),
          HouseSearchPage(key: keyForSearch,),
          HousePage(
            house: House(
              address: 'Erngworu fweofhw',
              ceilingHeight: 2.7,
              cost: 3500000,
              description: "",
              housingComplex: "Вишняки",
              maxDate: "2026-08-08",
              minDate: "2024-08-08",
              repair: true,
              roomCount: 3,
              squareMeters: 48,
              state: 'FEWf',
              planUrl: "",
              images: [],
              coord: LatLng(48, 48),
            ),
          ),
          const CalculatorPage(initialCost: null),
          const ChartsPage(),
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
      body: FiltersInherit(
        filterValues: filters,
        child: ChangeNotifierProvider(
          create: (_) => filters,
          child: Row(
            children: [
              SideMenu(key: sideMenu,
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
                    _buildOffstageNavigator(3),
                    _buildOffstageNavigator(4),
                    _buildOffstageNavigator(5),
                    _buildOffstageNavigator(6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
