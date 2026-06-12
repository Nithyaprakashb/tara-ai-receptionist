class BleConstants {
  BleConstants._();

  // Device
  static const String deviceName = 'TARA';

  // Service UUID
  static const String serviceUuid =
      '12345678-1234-1234-1234-1234567890AB';

  // Characteristic UUID
  static const String characteristicUuid =
      '22222222-2222-2222-2222-222222222222';

  // Expressions
  static const String happy =
      'EXPRESSION:HAPPY';

  static const String listening =
      'EXPRESSION:LISTENING';

  static const String thinking =
      'EXPRESSION:THINKING';

  static const String talking =
      'EXPRESSION:TALKING';

  static const String sleeping =
      'EXPRESSION:SLEEPING';

  static const String idle =
      'EXPRESSION:IDLE';

  // Relay Commands
  static const String relay1On =
      'RELAY1:ON';

  static const String relay1Off =
      'RELAY1:OFF';

  static const String relay2On =
      'RELAY2:ON';

  static const String relay2Off =
      'RELAY2:OFF';

  // Dynamic Commands
  static String news(String message) =>
      'NEWS:$message';

  static String announcement(String message) =>
      'ANNOUNCE:$message';
}