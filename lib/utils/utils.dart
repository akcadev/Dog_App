import 'package:flutter/services.dart';

class Utils {
  Future<String> getOSVersion() async {
    String version;
    try {
      final String result =
          await const MethodChannel('com.example.dog_app/os_version')
              .invokeMethod('getOSVersion');
      version = result;
    } on PlatformException catch (e) {
      version = 'Failed to get OS version: $e';
    }
    return version;
  }
}
