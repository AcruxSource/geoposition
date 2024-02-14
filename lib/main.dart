import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loggy/loggy.dart';

import 'database/domain/myposition.controller.dart';
import 'ui/controllers/geo.controller.dart';
import 'ui/controllers/network.controller.dart';
import 'ui/home.ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(
    showColors: true,
  ));
  initializeDateFormatting();
  await Firebase.initializeApp();

  Get.put(NetworkController());
  Get.put(GeoController());
  Get.put(MyPositionController());

  runApp(const Home());
}



