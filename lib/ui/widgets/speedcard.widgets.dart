import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/geo.controller.dart';

class CurrentSpeed extends StatefulWidget {
  const CurrentSpeed({super.key});

  @override
  State<CurrentSpeed> createState() => CurrentSpeedState();
}

class CurrentSpeedState extends State<CurrentSpeed> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.speed,
                size: 25,
                color: Color.fromARGB(132, 0, 0, 0),
              ),
              const Text(
                '  Velocidad: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      geoctl.speed.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
         
            
      


      // 