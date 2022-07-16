import 'package:build_link/ui/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MiniMap extends StatelessWidget {
  const MiniMap({Key? key, required this.coord, this.onTap}) : super(key: key);

  final LatLng coord;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            MapPage(initialPosition: coord),
            GestureDetector(
              onTap: () {
                onTap?.call();
              },
              child: Container(
                color: Colors.grey.withOpacity(0.000001),
              ),
            )
          ],
        ),
      ),
    );
  }
}
