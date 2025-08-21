import 'package:flutter/material.dart';
import 'package:flutter_review/getx/employee_file_screen/employee_controller_file.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class EmployeeView extends StatelessWidget {
  EmployeeView({super.key});

  final EmpController controller = Get.put(EmpController());

  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final positionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                nameCtrl.clear();
                ageCtrl.clear();
                positionCtrl.clear();
                controller.editingIndex.value = null;
                Get.back();
              },
            ),
            title: Text('Employee File'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: ageCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Age',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter age';
                      }
                      final age = int.tryParse(value.trim());
                      if (age == null) {
                        return 'Age must be integer not decimal number';
                      }
                      if(age <= 0) return 'Age must be greater than 0';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: positionCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Position'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter position';
                      }
                      return null;
                    },
                  ),
                  Obx(() {
                    final isEdited = controller.editingIndex.value != null;
                    return ElevatedButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
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
                        }
                      },
                      child: Text(
                        isEdited ? 'Save' : 'Add Employee',
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
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            showDialog(
                                              context: context, 
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.grey.withAlpha(255),
                                                  title: Text('Are you sure?', style: TextStyle(color: Colors.black)),
                                                  content: Text('Do you want to delete this employee?', style: TextStyle(color: Colors.black),),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Cancel', style: TextStyle(color: Colors.black)),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                                                      onPressed: () {
                                                        controller.deleteAt(index);
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                ],);
                                              }
                                            );
                                            // controller.deleteAt(index);
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
          ),
        ));
  }
}

