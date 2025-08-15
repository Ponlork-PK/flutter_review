import 'package:flutter/material.dart';
import 'package:flutter_review/core/service/share_preferences.dart';
import 'package:flutter_review/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalService.instance.init();
  runApp(const MyApp());
}

