import 'package:flutter/material.dart';
import 'package:flutter_review/getx/employee_shp_screen/home_controller.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final HomeController controller = Get.put(HomeController());

  void showDialog({EmpModel? employee, int? index}) {

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: employee?.name ?? '');
    final ageController = TextEditingController(text: employee?.age.toString() ?? '');
    final positionController = TextEditingController(text: employee?.position ?? '');

    Get.defaultDialog(
      title: employee == null ? "Add Employee" : "Edit Employee",
      backgroundColor: employee == null ? Colors.white : Colors.grey.withAlpha(255),
      content: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age', labelStyle: TextStyle(color: Colors.black)),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter age';
                }
                final age = int.tryParse(value.trim());
                if (age == null) {
                  return 'Age must be integer not decimal number';
                }
                if (age <= 0) {
                  return 'Age must be greater than 0';
                }
                return null;
              },
            ),
            TextFormField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position', labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter position';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      textCancel: "Cancel",
      cancelTextColor: Colors.red,
      textConfirm: "Done",
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (formKey.currentState!.validate()) {
          final name = nameController.text.trim();
          final age = int.tryParse(ageController.text.trim()) ?? 0;
          final position = positionController.text.trim();

          final newEmp = EmpModel(name: name, age: age, position: position);

          if (employee == null) {
            controller.addEmployee(newEmp);
          } else {
            controller.updateEmployee(index!, newEmp);
          }
          nameController.clear();
          Get.back();
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Employee Shared Preference"),),
        body: Obx(() {
          if (controller.setTextValue.isEmpty) {
            return Center(child: Text("No employees yet"));
          }
          return ListView.builder(
            itemCount: controller.setTextValue.length,
            itemBuilder: (_, index) {
              final emp = controller.setTextValue[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:  10.0),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${emp.name}', style: TextStyle(color: Colors.white)),
                            Text('Age: ${emp.age}', style: TextStyle(color: Colors.white)),
                            Text('Position: ${emp.position}', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.deepPurple),
                              onPressed: () => showDialog(employee: emp, index: index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => Get.defaultDialog(
                                backgroundColor: Colors.grey.withAlpha(255),
                                title: 'Are you sure?',
                                titleStyle: TextStyle(color: Colors.black),
                                content: Text('Do you want to delete this employee?', style: TextStyle(color: Colors.black),),
                                textCancel: 'No',
                                cancelTextColor: Colors.black,
                                textConfirm: 'Yes',
                                confirmTextColor: Colors.red,
                                onConfirm: () {
                                  controller.deleteEmployee(index);
                                  Get.back();
                                },
                              )
                              // controller.deleteEmployee(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(),
          child: Icon(Icons.add),
        ),
      ),
    );
}
}