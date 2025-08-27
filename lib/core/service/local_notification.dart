import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  // Private constructure for singleton pattern
  LocalNotification._internal();

  // Singleton instance
  static final LocalNotification _instance = LocalNotification._internal();

  // Factory constructor to return singleton instance
  factory LocalNotification.instance() => _instance;

  // Main plugin instance for handling notifications
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Android spacific initialization settings using app laucher icon
  final _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

  // Android notification channel configuration
  final _androidChannel = const AndroidNotificationChannel(
    'channel_id', 
    'channel_name',
    description: 'Android push notification channel',
    importance: Importance.max
  );


  // Flag to track initialization status
  bool _isFlutterLocalNotificationsInitialized = false;

  // Counter for generating unique notification ids
  int _notificationIdCounter = 0;

  // Initialize the local notification plugin for android and ios
  Future<void> init() async {
    // check if already initialized to prevent redundant setup
    if (_isFlutterLocalNotificationsInitialized) return;
    
    // Create plugin instance
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Combine platform-specific settings
    final initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    // Initialize plugin with settings and callback for notification taps
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {

        // Handle notification tap in foreground
        print('Foreground notification has been tapped: ${response.payload}');
      }
    );

    // Create Android notification channel
    await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_androidChannel);

    // Mark initialization as completed
    _isFlutterLocalNotificationsInitialized = true;
  
  }

  // Show a local notification with the given title and body
  Future<void> showNotification(String title, String body, String? payload) async {
    // Android-specific notification details
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _androidChannel.id, 
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.max,
      priority: Priority.high,
    );

    // Combine platform-specific notification details
    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );


    // Display the notification
    await _flutterLocalNotificationsPlugin.show(
      _notificationIdCounter++, 
      title, 
      body, 
      notificationDetails,
      payload: payload,
    );
  }
}