import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internal_assessment_app/utils/latest_order_date_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class NotificationService {
  static const String BACKGROUND_TASK_NAME = 'checkInactivity';
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize Workmanager
    await Workmanager().initialize(callbackDispatcher);
    
    // Register periodic task
    await Workmanager().registerPeriodicTask(
      'inactivityCheck',
      BACKGROUND_TASK_NAME,
      frequency: const Duration(days: 1), // Check daily
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );

    // Initialize notifications
    const initializationSettingsAndroid = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notifications.initialize(initializationSettings);
  }

  static Future<void> checkInactivity() async {
    final prefs = await SharedPreferences.getInstance();

    DateTime lastOrderDate = DateTime.now().subtract(const Duration(days: 15));

    // DateTime lastOrderDate = DateTime.now();
    // if (FirebaseAuth.instance.currentUser != null) {
    //   final userDoc = await FirebaseFirestore.instance
    //     .collection('appUsers')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get();
        
    //   final orderDate = userDoc.data()?['lastOrderDate']?.toDate();
    //   if (orderDate != null) {
    //   lastOrderDate = orderDate;
    //   }
    // }

    final daysSinceLastOrder = 
        DateTime.now().difference(lastOrderDate).inDays;

    if (daysSinceLastOrder >= 14) {
      await showInactivityNotification();
    }
  }

  static Future<void> showInactivityNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'inactivity_channel',
      'Inactivity Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      0,
      'Miss you!',
      'It\'s been 2 weeks since your last order. Check out our latest products!',
      details,
    );
  }
}

// This callback must be declared as a top-level function
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case NotificationService.BACKGROUND_TASK_NAME:
        await NotificationService.checkInactivity();
        break;
    }
    return Future.value(true);
  });
}