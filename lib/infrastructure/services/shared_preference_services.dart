import 'package:familystars_2/infrastructure/constants/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class manage persistent storage for simple data
class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferenceService?> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferenceService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  // General Methods: ----------------------------------------------------------

  Future<void> removeAllPrefrence() async {
    await _preferences?.clear();
  }

  Future<void> saveValue(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future<void> removeValue(String key) async {
    await _preferences?.remove(key);
  }

  String? getValue(String key) {
    try {
      return _preferences?.getString(key);
    } catch (e) {
      return '';
    }
  }

  Future<void> saveInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int? getInt(String key) {
    try {
      return _preferences?.getInt(key);
    } catch (e) {
      return -1;
    }
  }

  /// save intro screen flag
  Future<void> saveIntro(bool value) async {
    await _preferences?.setBool(StorageConstants.IsIntroHide, value);
  }

  /// get the intro screen flag
  bool? getIntro() {
    try {
      return _preferences?.getBool(StorageConstants.IsIntroHide);
    } catch (e) {
      return true;
    }
  }

  /// save user id
  Future<void> saveUser(String userid) async {
    await _preferences?.setString(StorageConstants.user, userid);
  }

  /// get user id
  String? getUser() {
    try {
      String? encodeData = _preferences?.getString(StorageConstants.user);
      return encodeData;
    } catch (e) {
      return null;
    }
  }
}
