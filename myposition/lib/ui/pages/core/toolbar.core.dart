import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myposition/ui/controller/network.controller.dart';

/* ----------------------- ToolBar ---------------------- */
NetworkController controller = Get.find();

AppBar appBar = AppBar(
  backgroundColor: const Color.fromARGB(216, 20, 20, 20),
  toolbarHeight: 40,
  title: const Text('Datos De Posicion'),
  titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  actions: [
    Row(
      /* ****************************************************** */
      children: [
        const Icon(
          Icons.online_prediction,
          size: 30,
        ),
        /* ****************************************************** */
        const SizedBox(
          width: 10,
        ),
        /* ****************************************************** */
        Column(
          children: [
            const Text("Estado de la red"),
            Obx(() => Text(controller.connectivityResult))
          ],
        ),

        /* ****************************************************** */
      ],
    )
  ],
);
