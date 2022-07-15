import 'package:build_link/ui/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Build-link')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Платформа для агентства недвижимости и агента'),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MapPage(
                        initialPosition: LatLng(0, 0),
                        isFullScreen: true,
                      );
                    },
                  ),
                );
              },
              child: const Text('Карта'),
            ),
          ],
        ),
      ),
    );
  }
}
