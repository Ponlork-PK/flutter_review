import 'dart:convert';

import 'package:flutter_review/models/emp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static final LocalService _sharePreferences = LocalService._internal();
  LocalService._internal();

  late SharedPreferences _pref;

  static const String _key = 'employees';

  static LocalService get instance => _sharePreferences;


  /// fetch data
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }


  Future<List<EmpModel>> getEmployees() async {
    final data = _pref.getString(_key);
    if (data != null) {
      List decoded = jsonDecode(data);
      return decoded.map((e) => EmpModel.fromMap(e)).toList();
    }
    return [];
  }


  Future<void> saveEmployee(List<EmpModel> emp) async{
    final encoded = jsonEncode(emp.map((e) => e.toMap()).toList());
    await _pref.setString(_key, encoded);
  }
}
