import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

import '../../core/geolocator.core.dart';

class GeoController extends GetxController {
  final GeoInfo _geoInfo = GeoInfo();
  var longitude = 0.0.obs;
  var latitude = 0.0.obs;
  var speed = 0.0.obs;
  var date = '1900-01-01'.obs;
  var time = '00:00'.obs;

  Future<void> opensettings() async {
    var status = await _geoInfo.getStatusGpsPermission();
    if (status.isPermanentlyDenied || status.isDenied) {
      openAppSettings();
    }
  }

  void dateFormatter(DateTime dateGPS) {
    var dateFormat = DateFormat.yMMMEd('es');
    date.value = dateFormat.format(dateGPS);
    dateFormat = DateFormat.jmz();
    time.value = dateFormat.format(dateGPS);
  }

  Future<void> getPosition() async {
    try {
      var status = await _geoInfo.getStatusGpsPermission();
      if (!status.isGranted) status = await _geoInfo.requestGpsPermission();
      if (status.isGranted) {
        final gps = await _geoInfo.getCurrentPosition();
        longitude.value = gps.longitude;
        latitude.value = gps.latitude;
        speed.value = gps.speed;

        dateFormatter(gps.timestamp!.toLocal());
        return;
      }
      longitude.value = 0;
      latitude.value = 0;
      speed.value = 0;
      date.value = '1900-01-01';
      time.value = '00:00';

      return;
    } catch (e) {
      longitude.value = 0;
      latitude.value = 0;
      speed.value = 0;
      date.value = '1900-01-01';
      time.value = '00:00';

      return Future.error(e);
    }
  }

  @override
  Future onInit() async {
    super.onInit();
    await getPosition();

    _geoInfo.getPositionStream.listen((Position? position) {
      if (position != null) {
        longitude.value = position.longitude;
        latitude.value = position.latitude;
        speed.value = position.speed;
      }
    });
  }

  @override
  void onClose() {
    longitude.close();
    latitude.close();
    speed.close();
    date.close();
    time.close();
  }
}
