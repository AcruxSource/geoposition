import 'package:firebase_database/firebase_database.dart';

class MyPosition {
  String? key;
  String date;
  String time;
  double latitude;
  double longitude;

  MyPosition(this.date, this.time, this.latitude, this.longitude);

  MyPosition.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json)
      : key = snapshot.key ?? '0',
        date = json['date'] ?? '1900-01-01',
        time = json['time'] ?? '00:00',
        latitude = json['latitude'] ?? 0.0,
        longitude = json['longitude'] ?? 0.0;

  toJson() {
    return {
      'date': date,
      'time': time,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}
