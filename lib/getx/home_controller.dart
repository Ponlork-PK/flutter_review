import 'package:flutter/material.dart';
import 'package:flutter_review/local_storage/share_preferences.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  var textNameEditingController = TextEditingController();
  var textAgeEditingController = TextEditingController();
  var textPositionEditingController = TextEditingController();

  final _setTextNameValue = ''.obs;
  final _setTextAgeValue = ''.obs;
  final _setTextPositionValue = ''.obs;

  List _setTextValue = [].obs;

  void setTextName(String value) {
    LocalService.instance.setData('emp1', value);
    _setTextNameValue.value = value;
  }

  void setStringList(List<String> value) {
    LocalService.instance.setEmpData('emp1', value);
    _setTextValue = value;
  }

  get getStringList {
    _setTextValue;
  }
  // void setTextAge(String value) => _setTextAgeValue.value = value;
  // void setTextPosition(String value) => _setTextPositionValue.value = value;

  // get getTextName => _setTextNameValue.value;
  // get getTextAge => _setTextAgeValue.value;
  // get getTextPosition => _setTextPositionValue.value;

  @override
  void onClose() {
    textNameEditingController.dispose();
    textAgeEditingController.dispose();
    textPositionEditingController.dispose();
    super.onClose();
  }
}


//Controller
// class HomeController extends GetxController {
//   final textNameEditingController = TextEditingController();
//   final textAgeEditingController = TextEditingController();
//   final textPositionEditingController = TextEditingController();

//   final _setTextNameValue = ''.obs;
//   final _setTextAgeValue = ''.obs;
//   final _setTextPositionValue = ''.obs;

//   void setTextName(String v) => _setTextNameValue.value = v;
//   void setTextAge(String v) => _setTextAgeValue.value = v;
//   void setTextPosition(String v) => _setTextPositionValue.value = v;

//   @override
//   void onClose() {
//     textNameEditingController.dispose();
//     textAgeEditingController.dispose();
//     textPositionEditingController.dispose();
//     super.onClose();
//   }
// }
