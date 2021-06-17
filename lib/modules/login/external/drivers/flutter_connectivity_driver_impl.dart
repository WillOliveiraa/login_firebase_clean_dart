import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/drivers/connectivity_driver.dart';

class FlutterConnectivityDriver implements ConnectivityDriver {
  final Connectivity connectivity;

  FlutterConnectivityDriver(this.connectivity);

  @override
  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }
}
