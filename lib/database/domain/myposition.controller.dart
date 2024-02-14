import 'dart:async';
import 'package:get/get.dart';
import '../model/myposition.model.dart';
import 'package:loggy/loggy.dart';
import 'package:firebase_database/firebase_database.dart';

class MyPositionController extends GetxController {
  final _positions = <MyPosition>[].obs;
  final String dbName = 'geo';

  final db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> newData;
  late StreamSubscription<DatabaseEvent> updateData;

  List<MyPosition> get positions => _positions;

  Future<void> addPosition(MyPosition position) async {
    logInfo('New Position...');
    try {
      db.child(dbName).push().set(position.toJson());
    } catch (e) {
      logError('Error Add: $e');
      return Future.error(e);
    }
  }

  Future<void> deletePosition(MyPosition position, int index) async {
    logInfo('Delete Message... $position.key');
    try {
      db
          .child(dbName)
          .child(position.key!)
          .remove()
          .then((value) => _positions.removeAt(index));
    } catch (e) {
      logError('Error Delete: $e');
      return Future.error(e);
    }
  }

  _onAddData(DatabaseEvent event) {
    logInfo('Data was Add...');
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _positions.add(MyPosition.fromJson(event.snapshot, json));
  }

  // Metodo que escucha las actualizaciones de registros
  _onUpdateData(DatabaseEvent event) {
    logInfo('Data was Updated...');
    var oldData = _positions.singleWhere((element) {
      return element.key == event.snapshot.key;
    });

    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _positions[_positions.indexOf(oldData)] =
        MyPosition.fromJson(event.snapshot, json);
  }

  @override
  void onInit() {
    super.onInit();
    _positions.clear();
    newData = db.child(dbName).onChildAdded.listen(_onAddData);
    updateData = db.child(dbName).onChildChanged.listen(_onUpdateData);
  }

  @override
  void onClose() {
    newData.cancel();
    updateData.cancel();
  }
}
