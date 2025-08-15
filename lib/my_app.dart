import 'package:flutter/material.dart';
// import 'package:flutter_review/getx/home_binding.dart';
import 'package:flutter_review/screens/all_widget.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Review',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialBinding: HomeBinding(),
      home: AllWidget(),
    );
  }
}