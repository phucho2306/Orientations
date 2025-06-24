import 'dart:io';

import 'package:flutter/services.dart';
import 'package:orientations/orientations_method_channel.dart';

class OrientationsPlugin {
  static final OrientationsPlugin _instance = OrientationsPlugin._internal();
  OrientationsPlugin._internal();
  factory OrientationsPlugin() {
    return _instance;
  }

  void setPreferredOrientations(List<DeviceOrientation> orientations) {
    if (Platform.isIOS) {
      MethodChannelOrientations.setOrientations(orientations);
    } else {
      SystemChrome.setPreferredOrientations(orientations);
    }
  }
}
