import 'package:get/get.dart';
import '../../core/network.core.dart';

class NetworkController extends GetxController {
  final NetworkInfo _networkInfo = NetworkInfo();

  final _connection = false.obs;

  bool get connection => _connection.value;

  @override
  Future onInit() async {
    super.onInit();
    final result = await _networkInfo.initConnectivity();
    if (result == true) {
      _connection.value = await _networkInfo.internetConnection();
    } else {
      _connection.value = false;
    }

    _networkInfo.onChanged.listen((event) async {
      _connection.value = await _networkInfo.internetConnection();
    });
  }

  @override
  void onClose() {
    _connection.close();
  }
}
