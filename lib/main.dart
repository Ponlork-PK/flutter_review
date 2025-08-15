import 'package:flutter/material.dart';
import 'package:flutter_review/local_storage/share_preferences.dart';
import 'package:flutter_review/my_app.dart';

void main() async{
  await LocalService.instance.init();
  runApp(const MyApp());
}

