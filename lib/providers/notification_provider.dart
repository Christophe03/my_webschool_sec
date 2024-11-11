import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  bool? _subscribed;
  bool? get subscribed => _subscribed;

  Future initFirebasePushNotification(context) async {
    if (Platform.isIOS) {
      // _fcm.onIosSettingsRegistered.listen((event) {
      //   print('event: $event');
      // });
      // _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    handleFcmSubscribtion();
    // handleFcmSubscribtion();
    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     showinAppDialog(context, message['notification']['title'],
    //         message['notification']['body']);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     nextScreen(context, NotificationsPage());
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     handleNotificationlength();
    //     print("onResume: $message");
    //   },
    // );

    notifyListeners();
  }

  Future handleFcmSubscribtion() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool _getsubcription = sp.getBool('subscribe') ?? true;
    if (_getsubcription == true) {
      await sp.setBool('subscribe', true);
      // _fcm.subscribeToTopic(subscriptionTopic);
      _subscribed = true;
      // print('subscribed');
    } else {
      await sp.setBool('subscribe', false);
      // _fcm.unsubscribeFromTopic(subscriptionTopic);
      _subscribed = false;
      // print('unsubscribed');
    }

    notifyListeners();
  }

  Future fcmSubscribe(bool isSubscribed) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('subscribe', isSubscribed);
    handleFcmSubscribtion();
  }
}
