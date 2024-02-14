/* ----------------------- Packege ---------------------- */
import 'package:get/get.dart';

/* ----------------------- Library ---------------------- */
import 'core/networkInfo.core.dart';

/* ------------------ NetworkController ----------------- */
class NetworkController extends GetxController {
  final NetworkInfo _networkInfo = NetworkInfo();
  final _connectivityResult = 'none'.obs;
  String get connectivityResult => _connectivityResult.value;

/* ****************************************************** */
  @override
  Future onInit() async {
    super.onInit();
    final result = await _networkInfo.initConnectivity();
    if (result != 'Ninguno') {
      _connectivityResult.value = result;
    }

    _networkInfo.onChanged.listen(
      (event) async {
        final result = await _networkInfo.internetConnection();
        if (result != 'Ninguno') {
          _connectivityResult.value = result;
        }
      },
    );
  }

  @override
  void onClose() {
    _connectivityResult.close();
  }
}
