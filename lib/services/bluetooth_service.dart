import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../core/constants/ble_constants.dart';

class BluetoothService {
BluetoothService._();

static final BluetoothService instance =
BluetoothService._();

BluetoothDevice? _device;

BluetoothCharacteristic? _characteristic;

StreamSubscription<List<ScanResult>>?
_scanSubscription;

bool get isConnected =>
_device?.isConnected == true;

BluetoothDevice? get device => _device;

// ------------------------------------------------
// Connect To TARA
// ------------------------------------------------

Future<bool> connectToTara() async {
try {
await FlutterBluePlus.stopScan();

  await FlutterBluePlus.startScan(
    timeout: const Duration(
      seconds: 15,
    ),
  );

  final completer =
      Completer<bool>();

  _scanSubscription =
      FlutterBluePlus.scanResults.listen(
    (results) async {
      for (final result
          in results) {
        try {
          print(
            'DEVICE => ${result.device.platformName}',
          );

          print(
            'LOCAL  => ${result.advertisementData.localName}',
          );

          print(
            'RSSI   => ${result.rssi}',
          );

          bool uuidMatch =
              false;

          for (final uuid
              in result
                  .advertisementData
                  .serviceUuids) {
            print(
              'UUID => $uuid',
            );

            if (uuid
                    .toString()
                    .toUpperCase() ==
                BleConstants
                    .serviceUuid
                    .toUpperCase()) {
              uuidMatch = true;
              break;
            }
          }

          bool nameMatch =
              result.device.platformName
                      .toUpperCase() ==
                  BleConstants
                      .deviceName
                      .toUpperCase() ||
              result
                      .advertisementData
                      .localName
                      .toUpperCase() ==
                  BleConstants
                      .deviceName
                      .toUpperCase();

          if (uuidMatch ||
              nameMatch) {
            print(
              'TARA FOUND',
            );

            await FlutterBluePlus
                .stopScan();

            _device =
                result.device;

            try {
              await _device!
                  .connect(
                timeout:
                    const Duration(
                  seconds: 10,
                ),
              );
            } catch (_) {}

            final success =
                await _discoverServices();

            if (!completer
                .isCompleted) {
              completer.complete(
                success,
              );
            }

            return;
          }
        } catch (_) {}
      }
    },
  );

  Future.delayed(
    const Duration(
      seconds: 15,
    ),
    () async {
      if (!completer
          .isCompleted) {
        await FlutterBluePlus
            .stopScan();

        completer.complete(
          false,
        );
      }
    },
  );

  return completer.future;
} catch (e) {
  print(
    'BLE ERROR: $e',
  );

  return false;
}

}

// ------------------------------------------------
// Discover Services
// ------------------------------------------------

Future<bool>
_discoverServices() async {
try {
final services =
await _device!
.discoverServices();

  for (final service
      in services) {
    print(
      'SERVICE => ${service.uuid}',
    );

    if (service.uuid
            .toString()
            .toUpperCase() ==
        BleConstants
            .serviceUuid
            .toUpperCase()) {
      for (final characteristic
          in service
              .characteristics) {
        print(
          'CHAR => ${characteristic.uuid}',
        );

        if (characteristic.uuid
                .toString()
                .toUpperCase() ==
            BleConstants
                .characteristicUuid
                .toUpperCase()) {
          _characteristic =
              characteristic;

          print(
            'CHARACTERISTIC FOUND',
          );

          return true;
        }
      }
    }
  }

  return false;
} catch (e) {
  print(
    'DISCOVERY ERROR: $e',
  );

  return false;
}

}

// ------------------------------------------------
// Disconnect
// ------------------------------------------------

Future<void> disconnect() async {
try {
await _device?.disconnect();
} catch (_) {}

_device = null;
_characteristic = null;

}

// ------------------------------------------------
// Send Command
// ------------------------------------------------

Future<bool> sendCommand(
String command,
) async {
try {
if (_characteristic ==
null) {
return false;
}

  await _characteristic!.write(
    utf8.encode(command),
    withoutResponse: false,
  );

  return true;
} catch (e) {
  print(
    'SEND ERROR: $e',
  );

  return false;
}

}

// ------------------------------------------------
// Expressions
// ------------------------------------------------

Future<bool> sendExpression(
String expression,
) async {
return sendCommand(
'EXPRESSION:$expression',
);
}

// ------------------------------------------------
// News
// ------------------------------------------------

Future<bool> sendNews(
String message,
) async {
return sendCommand(
'NEWS:$message',
);
}

// ------------------------------------------------
// Announcements
// ------------------------------------------------

Future<bool> sendAnnouncement(
String message,
) async {
return sendCommand(
'ANNOUNCE:$message',
);
}

// ------------------------------------------------
// Relay 1
// ------------------------------------------------

Future<bool> relay1On() async {
return sendCommand(
BleConstants.relay1On,
);
}

Future<bool> relay1Off() async {
return sendCommand(
BleConstants.relay1Off,
);
}

// ------------------------------------------------
// Relay 2
// ------------------------------------------------

Future<bool> relay2On() async {
return sendCommand(
BleConstants.relay2On,
);
}

Future<bool> relay2Off() async {
return sendCommand(
BleConstants.relay2Off,
);
}

// ------------------------------------------------
// Cleanup
// ------------------------------------------------

Future<void> dispose() async {
await _scanSubscription
?.cancel();

await disconnect();

}
}
