import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review/core/service/push_notification.dart';
import 'package:flutter_review/core/service/share_preferences.dart';
import 'package:flutter_review/firebase_options.dart';
import 'package:flutter_review/my_app.dart';


RemoteMessage? initialMessage;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalService.instance.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
  
  await PushNotification().initFCM();

}