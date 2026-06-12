import 'package:permission_handler/permission_handler.dart';

class BlePermissions {
  BlePermissions._();

  static Future<bool> request() async {
    final bluetoothScan =
        await Permission.bluetoothScan.request();

    final bluetoothConnect =
        await Permission.bluetoothConnect.request();

    final location =
        await Permission.locationWhenInUse.request();

    return bluetoothScan.isGranted &&
        bluetoothConnect.isGranted &&
        location.isGranted;
  }

  static Future<bool> isGranted() async {
    final bluetoothScan =
        await Permission.bluetoothScan.status;

    final bluetoothConnect =
        await Permission.bluetoothConnect.status;

    final location =
        await Permission.locationWhenInUse.status;

    return bluetoothScan.isGranted &&
        bluetoothConnect.isGranted &&
        location.isGranted;
  }
}