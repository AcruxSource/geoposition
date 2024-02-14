import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geoposition/database/domain/myposition.controller.dart';
import 'package:geoposition/ui/pages/home.page.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loggy/loggy.dart';

//ignore: must_be_immutable
class MapGoogle extends StatefulWidget {
  MapGoogle(this.index, {super.key});
  int index;

  @override
  State<MapGoogle> createState() => MapGoogleState();
}

class MapGoogleState extends State<MapGoogle> {
  MyPositionController posctl = Get.find();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  int get index => widget.index;

  Future<void> _goToNewYork() async {
    double lat = 75.1;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Get.to(() => const HomePage());
            },
            icon: const Icon(Icons.keyboard_double_arrow_left)),
        backgroundColor: const Color.fromARGB(216, 20, 20, 20),
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text(
          'Mi Localizacion',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(10.7599, -74.7915),
          zoom: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
