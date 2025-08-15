import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static final LocalService _sharePreferences = LocalService._internal();
  LocalService._internal();

  late SharedPreferences _pref;

  /// for access data
  static LocalService get instance => _sharePreferences;


  /// fetch data
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  // set string
  Future<void> setData(String key, String value) async {
    await _pref.setString(key, value);
  }
  // get string
  String getData(String key) {
    return _pref.getString(key) ?? '';
  }


  // Set List
  Future setEmpData(String key, List<String> value) async {
    await _pref.setStringList(key, value);
  }
  // Get List
  List<String> getEmpData(String key) {
    return _pref.getStringList(key) ?? [];
  }
}