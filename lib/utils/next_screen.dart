import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import '../views/notifications/widgets/custom_notification_details.dart';
import '../views/notifications/widgets/post_notification_details.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreeniOS(context, page) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

void nextScreenCloseOthers(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPopup(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
  );
}

void navigateToNotificationDetailsScreen(
    context, NotificationModel notificationModel) {
  if (notificationModel.postId == null) {
    nextScreen(context,
        CustomNotificationDeatils(notificationModel: notificationModel));
  } else {
    nextScreen(
        context, PostNotificationDetails(postID: notificationModel.postId!));
  }
}
