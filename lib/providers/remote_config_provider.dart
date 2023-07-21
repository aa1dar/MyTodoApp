import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/remote_config_repository.dart';

final remoteConfigProvider = Provider<RemoteConfigRepository>((ref) {
  final configInstance = FirebaseRemoteConfig.instance;
  return RemoteConfigRepository(configInstance);
});
