import 'package:flutter/services.dart';

class MethodChannelOrientations {
  static final _channel = const MethodChannel('orientations');

  static Future<void> setOrientations(List<DeviceOrientation> orientations) async {
    if (orientations.isEmpty) {
      throw ArgumentError('Orientations list cannot be empty.');
    }
    final List<String> orientationStrings = orientations.map((o) => o.toString().split('.').last).toList();

    await _channel.invokeMethod('setOrientations', {'orientations': orientationStrings});
  }
}
