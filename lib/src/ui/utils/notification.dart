import 'package:awesome_notifications/awesome_notifications.dart';
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

  Future<void> listenNotification(void Function() notif) {
    AwesomeNotifications().actionStream.listen((event) {
      if (event.channelKey == 'basic_channel') {
        notif;
      }
    });
  }

  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
  }
}
