import 'package:shared_preferences/shared_preferences.dart';

class RevisionLocalRepository {
  static const _networkRevisionSharedPrefsKey = 'network_revision';
  static const _localRevisionSharedPrefsKey = 'local_revision';
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _prefsInstance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // For remote storage
  Future<bool> saveNetworkRevision(int revision) async {
    final prefs = await _prefsInstance;
    return prefs.setInt(_networkRevisionSharedPrefsKey, revision);
  }

  Future<int?> getNetworkRevision() async {
    final prefs = await _prefsInstance;
    return prefs.getInt(_networkRevisionSharedPrefsKey);
  }

  // For local storage

  Future<bool> saveLocalRevision(int revision) async {
    final prefs = await _prefsInstance;
    return prefs.setInt(_localRevisionSharedPrefsKey, revision);
  }

  Future<int?> getLocalRevision() async {
    final prefs = await _prefsInstance;
    return prefs.getInt(_localRevisionSharedPrefsKey);
  }
}
