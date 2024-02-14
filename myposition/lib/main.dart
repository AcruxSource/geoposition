import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loggy/loggy.dart';
import 'package:myposition/ui/controller/network.controller.dart';

import 'ui/home.ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;

/* ----------------------- Loaders ---------------------- */
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  initializeDateFormatting('es_CO');

/* ---------------------- injectors --------------------- */
  Get.put(NetworkController());
  runApp(const Home());
}
