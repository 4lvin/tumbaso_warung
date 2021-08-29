import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:tumbaso_warung/src/ui/utils/notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data}");
  if (message.data != null) {
    if (message.data['content'] != null) {
      AwesomeNotifications().createNotificationFromJsonData(message.data);
    } else {
      if (message.data['tipe'] == 'maem') {
        CustomNotification().createNotificationSecond(
          message.data['title'],
          message.data['body'],
          message.data['image'],
        );
      } else if (message.data['tipe'] == 'barang') {
        CustomNotification().createNotificationPrimary(
          message.data['title'],
          message.data['body'],
          message.data['image'],
        );
      }
    }
  }
}

awesomeNotification() {
  AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
    NotificationChannel(
      channelKey: 'awesome_channel',
      channelName: 'Basic notifications',
      soundSource: 'resource://raw/notif',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.High,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      channelShowBadge: true,
      ledColor: Colors.white,
      defaultColor: Colors.teal,
    ),
    NotificationChannel(
      channelKey: 'barang_channel',
      channelName: 'Basic notifications',
      soundSource: 'resource://raw/notif',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.High,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      channelShowBadge: true,
      ledColor: Colors.white,
      defaultColor: Colors.teal,
    ),
    NotificationChannel(
      channelKey: 'maem_channel',
      channelName: 'Basic notifications',
      soundSource: 'resource://raw/notif',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.High,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      channelShowBadge: true,
      ledColor: Colors.white,
      defaultColor: Colors.teal,
    ),
  ]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('warung');
  awesomeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(App());
}
