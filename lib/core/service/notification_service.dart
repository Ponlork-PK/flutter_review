import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHanlder (RemoteMessage message) async{
  await NotificationService.instance.showNotification(message);
  await NotificationService.instance.setupFlutterNotification();
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messagig = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  void routeFromNotifData(Map<String, String> data) {
    final screen = data['screen'];
    if (screen == 'Notification_detail') {
      Get.toNamed('/detail', arguments: data);
    } else {
      // default or other routes…
      Get.toNamed('/home', arguments: data);
    }
  }


  Future<void> initialize () async{

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHanlder);

    await _requestPermission();
    final token = await _messagig.getToken();
    print('FCM token: $token');

    await setupMessageHandler();
    await setupFlutterNotification();

    await subscribeToTopic('all_devices');
  }

  Future<void> _requestPermission() async{
    final settings = await _messagig.requestPermission();
    print('Permission status: ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotification() async {
    if(_isFlutterLocalNotificationsInitialized) {
      return;
    }

    final androidChannel = AndroidNotificationChannel(
      'High_importance_channel_2',
      'High_importance_notifications',
      description: 'This channel is used for importance notifications',
      importance: Importance.high,
    );

    await _localNotification
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);

    final initializationAndroidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettings = InitializationSettings(
      android: initializationAndroidSettings
    );

    await _localNotification.initialize(
      initializationSettings,
      // Navigator
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        if( notificationResponse.payload != null ) {
          final data = Map<String, String>.from(jsonDecode(notificationResponse.payload!));
          routeFromNotifData(data);
        }
      },
    );
    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if( notification != null && android != null ) {
      await _localNotification.show(
        notification.hashCode,
        notification.title, 
        notification.body, 
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', 
            'high_importance_notifications',
            channelDescription: 'This channel is used for importance notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          )
        ),
        payload: message.data.isEmpty ? null : jsonEncode(message.data),
      );
    }
  }

  Future<void> setupMessageHandler() async {

    // On foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('OnMessage: ${message.notification?.title}');
      print('OnMessage: ${message.notification?.body}');
      showNotification(message);
    });

    // On background
    FirebaseMessaging.onMessageOpenedApp.listen(_onBackgroundMessageHandler);


    // On message opened app
    final initialMessage = await _messagig.getInitialMessage();
    if(initialMessage != null) {
      final data = Map<String, String>.from(initialMessage.data);
      // Route to background message (app terminated)
      WidgetsBinding.instance.addPostFrameCallback((_) => routeFromNotifData(data));
    }
  }
  
  void _onBackgroundMessageHandler(RemoteMessage message) {
    final data = Map<String, String>.from(message.data);
    if(message.notification != null) {
      routeFromNotifData(data);
    }
  }

  Future<void> subscribeToTopic(String topic) async{
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    print('Subscribe to : $topic');
  }
}
