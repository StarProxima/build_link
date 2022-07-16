import 'package:build_link/data/app_styles.dart';
import 'package:build_link/ui/pages/calendar_page.dart';
import 'package:build_link/ui/pages/charts_page.dart';
import 'package:build_link/ui/pages/map_page.dart';
import 'package:build_link/ui/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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
          const ChartsPage(),
          const CalendarPage(),
          MapPage(
            initialPosition: LatLng(0, 0),
            isFullScreen: true,
          ),
          Scaffold(
            body: Center(
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          Scaffold(
            body: Center(
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          )
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
      body: Row(
        children: [
          SideMenu(
            onChangePage: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
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
