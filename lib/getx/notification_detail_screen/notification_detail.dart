import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Map<String, String>.from(Get.arguments ?? {});
    final title = data['screen'] ?? 'N/A';
    final position = data['position'] ?? 'N/A';
    final name = data['name'] ?? '0';
    return Scaffold(
      appBar: AppBar(
        title: Text(title)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Hello, $name'),
                  Text('Position: $position'),
                ]
              )
            ],
          ),
          
        ],
      ),
    );
  }
}