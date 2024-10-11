
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/notification_model.dart';
import '../utils/constants_util.dart';
import '../utils/next_screen.dart';
import '../views/notifications/widgets/notification_dialog.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future _handleIosNotificationPermissaion() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future initFirebasePushNotification(context) async {
    if (Platform.isIOS) {
      _handleIosNotificationPermissaion();
    }
    String? _token = await _fcm.getToken();
    //print('User FCM Token : $_token');

    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    //debugPrint('inittal message : $initialMessage');
    if (initialMessage != null) {
      await saveNotificationData(initialMessage)
          .then((value) => _navigateToDetailsScreen(context, initialMessage));
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // debugPrint('onMessage: ${message.data}');
      await saveNotificationData(message)
          .then((value) => _handleOpenNotificationDialog(context, message));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await saveNotificationData(message)
          .then((value) => _navigateToDetailsScreen(context, message));
    });
  }

  Future _handleOpenNotificationDialog(context, RemoteMessage message) async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    NotificationModel notificationModel = NotificationModel(
      date: message.sentTime,
      description: message.data['description'],
      postId: message.data['post_id'],
      thumbnailUrl: message.data['image_url'],
      timestamp: _timestamp,
      title: message.notification!.title,
      subTitle: message.notification!.body,
    );
    openNotificationDialog(context, notificationModel);
  }

  Future _navigateToDetailsScreen(context, RemoteMessage message) async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    NotificationModel notificationModel = NotificationModel(
        timestamp: _timestamp,
        date: message.sentTime,
        title: message.notification!.title,
        description: message.data['description'],
        postId: message.data['post_id'],
        thumbnailUrl: message.data['image_url'],
        subTitle: message.notification!.body);
    navigateToNotificationDetailsScreen(context, notificationModel);
  }

  Future saveNotificationData(RemoteMessage message) async {
    final list = Hive.box(notificationTag);
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    Map<String, dynamic> _notificationData = {
      'timestamp': _timestamp,
      'date': message.sentTime,
      'title': message.notification!.title,
      'body': message.data['description'],
      'post_id': message.data['post_id'],
      'image': message.data['image_url'],
      'subtitle': message.notification!.body,
    };

    await list.put(_timestamp, _notificationData);
  }

  Future deleteNotificationData(key) async {
    final notificationList = Hive.box(notificationTag);
    await notificationList.delete(key);
  }

  Future deleteAllNotificationData() async {
    final notificationList = Hive.box(notificationTag);
    await notificationList.clear();
  }
}
