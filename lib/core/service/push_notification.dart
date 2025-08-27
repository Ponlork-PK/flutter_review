import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review/getx/notification_detail_screen/notification_detail.dart';
import 'package:get/get.dart';

class PushNotification {

  final _firebaseMessaging = FirebaseMessaging.instance;

  initFCM() async {

    await _firebaseMessaging.requestPermission();
    // await _firebaseMessaging.deleteToken();
    final token = await _firebaseMessaging.getToken();
    // ignore: avoid_print
    print('Device Token: $token');
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ignore: avoid_print
      // print('Message: ${message.notification?.title}');
      Get.to(NotificationDetail(title: message.notification?.title, body: message.notification?.body));
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      // print('Message: ${message.notification?.title}');
      // print('Message: ${message.notification?.body}');
      Get.defaultDialog(
        backgroundColor: Colors.grey.withAlpha(240),
        title: message.notification?.title ?? '',
        middleText: message.notification?.body ?? '',
        textCancel: 'Close',
        cancelTextColor: Colors.red,
        textConfirm: 'Open',
        confirmTextColor: Colors.deepPurple,
        onCancel: () => Get.back(),
        onConfirm: () {
          Get.back();
          Get.to(NotificationDetail(title: message.notification?.title, body: message.notification?.body));
        },
      );
    });

    /// For handling notification when the app is in background
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // ignore: avoid_print
        // print('Message: ${message.notification?.title}');
        Get.to(NotificationDetail(title: message.notification?.title, body: message.notification?.body));
      }
    });
  }
}