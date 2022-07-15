// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:developer';

import 'package:build_link/data/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;
import 'package:flutter_map/plugin_api.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
    required this.initialPosition,
    this.isFullScreen = false,
  }) : super(key: key);

  final LatLng initialPosition;

  final bool isFullScreen;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();
  late StreamSubscription subscription;
  // List<Suggestion> items = [];

  bool load = false;
  bool isMove = false;

  void clearItems() {
    //items.clear();
    setState(() {});
  }

  void loadSuggetions(String value) async {
    if (value.isEmpty) {
      clearItems();
      return;
    }
    await Future.delayed(const Duration(milliseconds: 300));
    if (value != searchController.text) return;
    if (load) return;
    load = true;
    // items = await GeocoderRepository.search(
    //   value,
    //   Coord(mapController.center.latitude, mapController.center.longitude),
    // );
    load = false;
    setState(() {});
  }

  final FocusNode searchFocus = FocusNode();

  void animatedMoveToCoord(LatLng coord) {
    final latTween = Tween<double>(
      begin: mapController.center.latitude,
      end: coord.latitude,
    );
    final lngTween = Tween<double>(
      begin: mapController.center.longitude,
      end: coord.longitude,
    );

    var controller = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(() {
      mapController.move(
        LatLng(
          latTween.evaluate(animation),
          lngTween.evaluate(animation),
        ),
        mapController.zoom,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });
    controller.forward();
  }

  void searchMyCoord() async {
    LatLng? coord = await getCurrentCoord();
    if (coord != null && mounted) {
      //UserProvider.of(context)?.coordModel.coord = coord;
    }
  }

  @override
  void initState() {
    mapController.onReady.then((_) {
      subscription = mapController.mapEventStream.listen((MapEvent mapEvent) {
        if (mapEvent is MapEventMoveStart) {
          isMove = true;
          setState(() {});
        }
        if (mapEvent is MapEventMoveEnd) {
          isMove = false;
          setState(() {});
        }
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (widget.isEditor) searchMyCoord();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mapController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.doubleTapZoom,
              zoom: 17,
              maxZoom: 18,
              minZoom: 7,
              crs: const Epsg3395(),
              onPositionChanged: (position, _isMove) {
                try {
                  if (searchFocus.hasFocus) {
                    clearItems();
                    searchFocus.unfocus();
                  }
                } catch (e) {}
              },
              center: widget.initialPosition,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://core-renderer-tiles.maps.yandex.net/tiles?l=map&x={x}&y={y}&z={z}&scale=2&lang=ru_RU',
                subdomains: ['a', 'b', 'c'],
              ),
              // MarkerLayerOptions(
              //   markers: widget.isEditor
              //       ? [
              //           // Marker(
              //           //   point: UserProvider.of(context)!
              //           //       .coordModel
              //           //       .coord
              //           //       .toLatLng(),
              //           //   builder: (context) {
              //           //     return const Center(
              //           //       child: Image(
              //           //         height: 20,
              //           //         width: 20,
              //           //         image: AppImages.userpin,
              //           //       ),
              //           //     );
              //           //   },
              //           // ),
              //         ]
              //       : [],
              // )
            ],
          ),
          // widget.isFullScreen
          //     ? Align(
          //         alignment: Alignment.bottomRight,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 16,
          //             vertical: 16,
          //           ),
          //           child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               primary: Theme.of(context).scaffoldBackgroundColor,
          //               elevation: 5,
          //               fixedSize: const Size(50, 50),
          //               shape: const CircleBorder(),
          //             ),
          //             child: Icon(
          //               Icons.near_me_outlined,
          //               color: Theme.of(context).primaryColor,
          //             ),
          //             onPressed: () async {
          //               animatedMoveToCoord(
          //                 mapController.center,
          //               );

          //               searchMyCoord();
          //             },
          //           ),
          //         ),
          //       )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}

class Epsg3395 extends Earth {
  @override
  final String code = 'EPSG:3395';

  @override
  final Projection projection = const Mercator();

  @override
  final Transformation transformation =
      const Transformation(_scale, 0.5, -_scale, 0.5);

  static const num _scale = 0.5 / (math.pi * Mercator.r);

  const Epsg3395() : super();
}

class Mercator extends Projection {
  static const int r = 6378137;
  static const double rMinor = 6356752.314245179;
  static final Bounds<double> _bounds = Bounds<double>(
    const CustomPoint<double>(-20037508.34279, -15496570.73972),
    const CustomPoint<double>(20037508.34279, 18764656.23138),
  );

  const Mercator() : super();

  @override
  Bounds<double> get bounds => _bounds;

  @override
  CustomPoint project(LatLng latlng) {
    var d = math.pi / 180;
    var y = latlng.latitude * d;
    var tmp = rMinor / r;
    var e = math.sqrt(1 - tmp * tmp);
    var con = e * math.sin(y);

    var ts =
        math.tan(math.pi / 4 - y / 2) / math.pow((1 - con) / (1 + con), e / 2);
    y = -r * math.log(math.max(ts, 1E-10));

    return CustomPoint(latlng.longitude * d * r, y);
  }

  @override
  LatLng unproject(CustomPoint point) {
    var d = 180 / math.pi;
    var tmp = rMinor / r;
    var e = math.sqrt(1 - tmp * tmp);
    var ts = math.exp(-point.y / r);
    var phi = math.pi / 2 - 2 * math.atan(ts);

    for (num i = 0, dphi = 0.1, con; i < 15 && dphi.abs() > 1e-7; i++) {
      con = e * math.sin(phi);
      con = math.pow((1 - con) / (1 + con), e / 2);
      dphi = math.pi / 2 - 2 * math.atan(ts * con) - phi;
      phi += dphi;
    }

    return LatLng(phi * d, point.x * d / r);
  }
}
