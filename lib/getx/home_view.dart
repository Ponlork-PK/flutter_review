import 'package:flutter/material.dart';
import 'package:flutter_review/getx/home_controller.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('GetX'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Add Employee'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        actions: [
                          TextField(
                            controller: controller.textNameEditingController,
                            decoration: InputDecoration(
                              hintText: 'name',
                            ),
                          ),
                          TextField(
                            controller: controller.textAgeEditingController,
                            decoration: InputDecoration(
                              hintText: 'age',
                            ),
                          ),
                          TextField(
                            controller: controller.textPositionEditingController,
                            decoration: InputDecoration(
                              hintText: 'position',
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: (){
                                  // Navigator.pop(context);
                                  Get.back();
                                }, 
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  // controller.setTextValue[controller.textNameEditingController.text, controller.textAgeEditingController.text, controller.textPositionEditingController.text];
                                  EmpModel(name: controller.textNameEditingController.text, age: controller.textAgeEditingController.text, position: controller.textPositionEditingController.text);
                                  // controller.setTextName(controller.textNameEditingController.text);
                                  // controller.setTextAge(controller.textAgeEditingController.text);
                                  // controller.setTextPosition(controller.textPositionEditingController.text);
                                  // Navigator.pop(context);
                                  Get.back();
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  );
                }, 
                icon: Icon(Icons.add)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
              1,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
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
                            Obx(()=> Text(controller.getStringList[index].toString())),
                            // Obx(()=> Text(controller.getTextName)),
                            // Obx(()=> Text(controller.getTextAge)),
                            // Obx(()=> Text(controller.getTextPosition)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                            IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
        )
        // Obx(
        //   () => Column(
        //     spacing: 20,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Number: ${controller.getCounter}',
        //         style: TextStyle(
        //           fontSize: 24,
        //         ),
        //       ),
        //       Row(
        //         spacing: 20,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           controller.getCounter == 0
        //               ? SizedBox()
        //               : ElevatedButton(
        //                   onPressed: () {
        //                     controller.decrement();
        //                   },
        //                   child: Text("-")),
        //           ElevatedButton(
        //               onPressed: () {
        //                 controller.increment();
        //               },
        //               child: Text("+"))
        //         ],
        //       )
        //     ],
        //   ),
        // )
    );
  }
}
