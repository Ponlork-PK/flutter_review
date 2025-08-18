import 'package:flutter/material.dart';
import 'package:flutter_review/getx/employee_shp_screen/home_controller.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final HomeController controller = Get.put(HomeController());

  void showDialog({EmpModel? employee, int? index}) {
    final nameController = TextEditingController(text: employee?.name ?? '');
    final ageController = TextEditingController(text: employee?.age.toString() ?? '');
    final positionController = TextEditingController(text: employee?.position ?? '');

    Get.defaultDialog(
      title: employee == null ? "Add Employee" : "Edit Employee",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: positionController,
            decoration: InputDecoration(labelText: 'Position'),
          ),
        ],
      ),
      textCancel: "Cancel",
      cancelTextColor: Colors.red,
      textConfirm: "Done",
      confirmTextColor: Colors.white,
      onConfirm: () {
        final name = nameController.text.trim();
        final age = int.tryParse(ageController.text.trim()) ?? 0;
        final position = positionController.text.trim();

        if (name.isNotEmpty && position.isNotEmpty && age > 0) {
          final newEmp = EmpModel(name: name, age: age, position: position);

          if (employee == null) {
            controller.addEmployee(newEmp);
          } else {
            controller.updateEmployee(index!, newEmp);
          }
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
        appBar: AppBar(centerTitle: true, title: Text("Employee List")),
        body: Obx(() {
          if (controller.setTextValue.isEmpty) {
            return Center(child: Text("No employees yet"));
          }
          return ListView.builder(
            itemCount: controller.setTextValue.length,
            itemBuilder: (_, index) {
              final emp = controller.setTextValue[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
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
                            Text('Name: ${emp.name}'),
                            Text('Age: ${emp.age}'),
                            Text('Position: ${emp.position}'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => showDialog(employee: emp, index: index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => controller.deleteEmployee(index),
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