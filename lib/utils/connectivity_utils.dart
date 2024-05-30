import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static Future<bool> get hasDeviceInternet async {
    return (await hasWifi) || (await hasMobileData);
  }

  static Future<bool> get hasWifi async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.wifi;
  }

  static Future<bool> get hasMobileData async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile;
  }
}
