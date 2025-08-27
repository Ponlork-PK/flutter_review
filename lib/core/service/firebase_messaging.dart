import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_review/core/service/local_notification.dart';

class FirebaseMessagingService {
  // Private constructor for singleton pattern
  FirebaseMessagingService._internal();

  // Singleton instance
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();


  // Factory constructor to provide the singleton instance
  factory FirebaseMessagingService.instance() => _instance;

  // Reference to the local notification service for diplay notifications
  LocalNotification? _localNotification;

  /// Initialize Firebase Messaging and set up all message listeners
  Future<void> init({required LocalNotification localNotification}) async {
    // Init local notification
    _localNotification = localNotification;
    

    // Handle FCM token
    _handlePushNotificationToken();


    // Request user permission for notifications
    _requestPermission();


    // Register handler for background messages (app terminated)
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    // Listen for message when app is in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);


    // Listen for message when app is in background not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);


    // check for initial message that opened the app from terminated
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  /// Handle FCM token
  Future<void> _handlePushNotificationToken() async{
    // Get the FCM token for the device

    final token = await FirebaseMessaging.instance.getToken();

    // Print the FCM token
    print('FCM token: $token');

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('FCM token refreshed: $newToken');
    }).onError((error) {
      // Handle token refresh errors
      print('Error refreshing FCM token: $error');
    });
  }


  // Handle request permission for notifications from the user
  Future<void> _requestPermission() async {
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // log the user's permission status
    print('User granted permission: ${result.authorizationStatus}');

  }

  // Handle messages received while the app is in the foreground
  void _onForegroundMessage(RemoteMessage message) async{
    print('Foreground message: ${message.data.toString()}');
    final notificationData = message.notification;
    if(notificationData != null) {
      
      // Display a local notification
      _localNotification!.showNotification(
        notificationData.title ?? '',
        notificationData.body ?? '',
        message.data.toString(),
      );
    }
  }


  // Handle messages received while the app in in the background not terminated
  void _onMessageOpenedApp(RemoteMessage message) async{
    print('Background Opened App message: ${message.data.toString()}');
    final notificationData = message.notification;
    if(notificationData != null) {
      
      // Display a local notification
      _localNotification!.showNotification(
        notificationData.title ?? '',
        notificationData.body ?? '',
        message.data.toString(),
      );
    }
  }
}

/// Handle background messages
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  print('Background message: ${message.data.toString()}');
}