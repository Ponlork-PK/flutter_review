import 'package:flutter_review/local_storage/share_preferences.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final setTextValue = <EmpModel>[].obs;

  @override
  void onInit() async {
    loadEmployee();
    super.onInit();
  }

  void loadEmployee() async {
    var list = await LocalService.instance.getEmployees();
    setTextValue.assignAll(list);
  }

  void addEmployee(EmpModel emp) async {
    setTextValue.add(emp);
    await LocalService.instance.saveEmployee(setTextValue);
  }

  void updateEmployee(int index, EmpModel emp) async {
    setTextValue[index] = emp;
    await LocalService.instance.saveEmployee(setTextValue);
  }

  void deleteEmployee(int index) async {
    setTextValue.removeAt(index);
    await LocalService.instance.saveEmployee(setTextValue);
  }
}
