import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GeoInfo {
  final LocationSettings settings = const LocationSettings(
      accuracy: LocationAccuracy.high, distanceFilter: 1);

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<PermissionStatus> requestGpsPermission() async {
    var status = await Permission.location.request();
    return Future.value(status);
  }

  Future<bool> statusGpsPermission() async {
    try {
      var status = await Permission.location.status;
      return Future.value(status.isGranted);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<PermissionStatus> getStatusGpsPermission() async {
    var status = await Permission.location.status;
    return Future.value(status);
  }

  Stream<Position> get getPositionStream =>
      Geolocator.getPositionStream(locationSettings: settings);
}
