import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions/extensions.dart';

import '../utils/logger/logger.dart';

class RemoteConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigRepository(this._remoteConfig);

  Color? get redColor {
    final stringColor = _remoteConfig.getString(_ConfigFields.redColor);
    return stringColor.toColor();
  }

  Future<void> init() async {
    Logger.d('REMOTE_CONFIG', 'Start fetching remote config');
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 30),
    ));
    await _remoteConfig.fetchAndActivate();
  }
}

abstract class _ConfigFields {
  static const redColor = 'red_color';
}
