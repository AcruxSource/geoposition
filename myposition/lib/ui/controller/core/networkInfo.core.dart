import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:loggy/loggy.dart';

/* --------------------- NetworkInfo -------------------- */
class NetworkInfo {
  final Connectivity _connectivity = Connectivity();

/* ****************************************************** */
  Future<String> initConnectivity() async {
    late ConnectivityResult connResult;
    try {
      connResult = await _connectivity.checkConnectivity();
    } catch (e) {
      logError('No se logro establecer el estado de la conexion, error: $e');
    }
    if (connResult != ConnectivityResult.none) {
      if (connResult == ConnectivityResult.wifi) return Future.value('Wifi');
      return Future.value('Mobil');
    }

    return Future.value('Ninguno');
  }

  /* ****************************************************** */
  Future<String> internetConnection() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      final typeResult = await InternetAddress.lookup('google.com',
          type: InternetAddressType.IPv4);
      if (typeResult.isNotEmpty) {
        logInfo('Estado de la red: OnLine');
        return Future.value(await initConnectivity());
      }
      logError('Estado de la red: OffLine');
      return 'Sin Red';
    } catch (e) {
      logError('Estado de la red: OffLine');
      return 'Sin Red';
    }
  }

/* ****************************************************** */
  Stream<ConnectivityResult> get onChanged =>
      _connectivity.onConnectivityChanged;
}
