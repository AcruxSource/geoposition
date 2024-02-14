import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/geo.controller.dart';

class CurrentPosition extends StatefulWidget {
  const CurrentPosition({super.key});

  @override
  State<CurrentPosition> createState() => CurrentPositionState();
}

class CurrentPositionState extends State<CurrentPosition> {
  GeoController geoctl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 252, 211, 90),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.gps_fixed,
                size: 25,
                color: Color.fromARGB(132, 0, 0, 0),
              ),
              Text(
                '  Mi Posicion',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Latitud: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                    geoctl.latitude.toStringAsFixed(4),
                    style: const TextStyle(fontSize: 20),
                  )),
              const Text(
                '  Longitud: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                    geoctl.longitude.toStringAsFixed(4),
                    style: const TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
