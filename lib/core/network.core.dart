import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:loggy/loggy.dart';

class NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  Future<bool> initConnectivity() async {
    late ConnectivityResult connResult;
    try {
      connResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      logError('No se logro establecer el estado de la conexion, error: $e');
    }
    if (connResult != ConnectivityResult.none) {
      logInfo('Network: Habilitado');
      return Future.value(true);
    }
    logInfo('Network: Deshabilitado');
    return Future.value(false);
  }

  Future<bool> internetConnection() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final typeResult = await InternetAddress.lookup('google.com',
          type: InternetAddressType.IPv4);
      if (typeResult.isNotEmpty) {
        logInfo('Estado de la red: OnLine');
        return Future.value(true);
      }
      return Future.value(false);
    } catch (e) {
      logError('Estado de la red: OffLine');
      return Future.value(false);
    }
  }

  Stream<ConnectivityResult> get onChanged =>
      _connectivity.onConnectivityChanged;
}
