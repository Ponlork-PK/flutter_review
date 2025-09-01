import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review/core/service/notification_service.dart';
import 'package:flutter_review/core/service/share_preferences.dart';
import 'package:flutter_review/my_app.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalService.instance.init();
  await Firebase.initializeApp();

  await NotificationService.instance.initialize();

  runApp(const MyApp());

}