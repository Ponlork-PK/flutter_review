import 'package:flutter/material.dart';
import 'package:flutter_review/screens/all_widget.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void onChangeTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Review',
      theme: _lightMode(),
      darkTheme: _darkMode(),
      
      // initialBinding: HomeBinding(),
      home: AllWidget(),
    );
  }

  ThemeData _lightMode (){
    return ThemeData(
      primaryColor: Colors.deepPurple,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),

      /// AppBar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white, 
          fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 5,
      ),

      /// ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 5,
        ),
      ),
      

      /// FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        iconSize: 40,
      ),

      /// Text
      textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 18)),


      /// Dialog
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      useMaterial3: true,
    );
  }

  ThemeData _darkMode (){
    return ThemeData(
      primaryColor: Colors.deepPurple,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),

      /// AppBar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white, 
          fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 5,
      ),

      /// ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 5,
        ),
      ),
      

      /// FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        iconSize: 40,
      ),

      /// Text
      textTheme: TextTheme (bodyMedium: TextStyle(fontSize: 18)),


      /// Dialog
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      useMaterial3: true,
    );
  }
}
