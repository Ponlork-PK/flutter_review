import 'package:flutter/material.dart';
import 'package:flutter_review/getx/employee_file_screen/employee_controller_file.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class EmployeeView extends StatelessWidget {
  EmployeeView({super.key});

  final EmpController controller = Get.put(EmpController());

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final positionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Text(
              'Employee Screen',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              spacing: 10,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Name'),
                ),
                TextField(
                  controller: ageCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Age',
                  ),
                ),
                TextField(
                  controller: positionCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Position'),
                ),
                Obx(() {
                  final isEdited = controller.editingIndex.value != null;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.deepPurple,
                    ),
                    onPressed: () async {
                      final name = nameCtrl.text.trim();
                      final age = int.tryParse(ageCtrl.text.trim()) ?? 0;
                      final position = positionCtrl.text.trim();
                      if(isEdited) {
                        await controller.updateAt(controller.editingIndex.value!, EmpModel(name: name, age: age.toInt(), position: position));
                      } else {
                        await controller.addEmployee(EmpModel( name: name, age: age.toInt(), position: position));
                      }
                      nameCtrl.clear();
                      ageCtrl.clear();
                      positionCtrl.clear();
                    },
                    child: Text(
                      isEdited ? 'Save' : 'Add Product',
                      style: TextStyle(color: Colors.white),
                    ));
                }),
                Expanded(
                  child: Obx(() => ListView.builder(
                      itemCount: controller.employees.length,
                      itemBuilder: (context, index) {
                        final emp = controller.employees[index];
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Name: ${emp.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Age: ${emp.age.toString()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Position: ${emp.position}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          nameCtrl.text = emp.name;
                                          ageCtrl.text = emp.age.toString();
                                          positionCtrl.text = emp.position;
                                          if( controller.editingIndex.value != emp.id ) {
                                            controller.editingIndex.value = index;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.deepPurple,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          controller.deleteAt(index);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),)
                ),
              ],
            ),
          ),
        ));
  }
}

