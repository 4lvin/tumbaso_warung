import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tumbaso_warung/src/ui/utils/utilities.dart';

class CustomNotification {
  Future<void> createNotification(
      String title, String body, String image) async {
    if (image == '') {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'awesome_channel',
          title: title,
          body: body,
          backgroundColor: Colors.teal,
          color: Colors.lime,
        ),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'awesome_channel',
          title: title,
          body: body,
          bigPicture: image == "" ? 'asset://assets/baru2.png' : image,
          notificationLayout: NotificationLayout.BigPicture,
          backgroundColor: Colors.teal,
          color: Colors.lime,
        ),
      );
    }
  }

  Future<void> createNotificationPrimary(
      String title, String body, String image) async {
    if (image == '') {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'barang_channel',
          title: title,
          body: body,
          backgroundColor: Colors.teal,
          color: Colors.lime,
        ),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'barang_channel',
          title: title,
          body: body,
          bigPicture: image == "" ? 'asset://assets/baru2.png' : image,
          notificationLayout: NotificationLayout.BigPicture,
          backgroundColor: Colors.teal,
          color: Colors.lime,
        ),
      );
    }
  }

  Future<void> createNotificationSecond(
      String title, String body, String image) async {
    if (image == '') {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'maem_channel',
          title: title,
          body: body,
          backgroundColor: Colors.teal,
          color: Colors.lime,
        ),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'maem_channel',
          title: title,
          body: body,
          bigPicture: image == "" ? 'asset://assets/baru2.png' : image,
          notificationLayout: NotificationLayout.BigPicture,
          backgroundColor: Colors.teal,
          color: Colors.lime,
        ),
      );
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

  typeNotif(RemoteMessage message) {
    if (message.data['content'] != null) {
      AwesomeNotifications().createNotificationFromJsonData(message.data);
    } else {
      if (message.data['tipe'] == 'maem') {
        createNotificationSecond(
          message.data['title'],
          message.data['body'],
          message.data['image'],
        );
      } else if (message.data['tipe'] == 'barang') {
        createNotificationPrimary(
          message.data['title'],
          message.data['body'],
          message.data['image'],
        );
      } else {
        createNotification(
          message.data['title'],
          message.data['body'],
          message.data['image'],
        );
      }
    }
  }
}
