import 'package:flutter_review/core/file_storage/file_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_review/models/emp_model.dart';

class EmpController extends GetxController {
  final employees = <EmpModel>[].obs;
  final editingIndex = RxnInt(); // null = add mode; number = editing that row
  final _store = EmpFileStore();

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    final list = await _store.loadEmployees();
    employees.assignAll(list);
  }

  int _nextId() {
    final ids = employees.map((e) => e.id ?? 0).toList();
    if (ids.isEmpty) return 1;
    ids.sort();
    return ids.last + 1;
  }

  Future<void> addEmployee(EmpModel emp) async {
    final withId = emp.id == null ? EmpModel(
      id: _nextId(),
      name: emp.name,
      age: emp.age,
      position: emp.position,
    ) : emp;

    employees.add(withId);
    await _store.saveAll(employees);
  }

  Future<void> updateAt(int index, EmpModel e) async {
    if (index < 0 || index >= employees.length) return;
    final current = employees[index];
    final updated = EmpModel(
      id: current.id ?? e.id ?? _nextId(), // keep existing id
      name: e.name,
      age: e.age,
      position: e.position,
    );
    employees[index] = updated;
    await _store.saveAll(employees);
    editingIndex.value = null;
  }

  Future<void> deleteAt(int index) async {
    if (index < 0 || index >= employees.length) return;
    employees.removeAt(index);
    await _store.saveAll(employees);
    if (editingIndex.value == index) editingIndex.value = null;
  }

  void startEditing(int index) => editingIndex.value = index;
  void cancelEditing() => editingIndex.value = null;
}
