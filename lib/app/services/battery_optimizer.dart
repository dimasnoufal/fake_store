import 'package:flutter/services.dart';

class BatteryOptimizer {
  static const platform = MethodChannel('battery_optimizer_channel');

  static Future<bool> checkStatusBatteryOptimizations() async {
    try {
      final bool result =
          await platform.invokeMethod('isIgnoringBatteryOptimizations');
      print(" battery optimizations: $result");
      return result;
    } on PlatformException catch (e) {
      print("Failed to check battery optimizations: ${e.message}");
      return false;
    }
  }

  static requestIgnoreBatteryOptimizations() {
    try {
      platform.invokeMethod('requestIgnoreBatteryOptimizations');
    } on PlatformException catch (e) {
      print('Failed to open settings: $e');
    }
  }
}
