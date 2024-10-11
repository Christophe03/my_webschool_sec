import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
import '../../../services/app_service.dart';
import '../../../services/notification_service.dart';
import '../../../utils/cached_image.dart';

class PostNotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  final String timeAgo;
  const PostNotificationCard(
      {Key? key, required this.notificationModel, required this.timeAgo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    notificationModel.thumbnailUrl == ''
                        ? Container()
                        : Container(
                            height: 90,
                            width: 90,
                            child: CustomCacheImage(
                                imageUrl: notificationModel.thumbnailUrl,
                                height: 200,
                                radius: 5)),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 90,
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppService.getNormalText(notificationModel.title!),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.time,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(timeAgo,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                Spacer(),
                                IconButton(
                                    alignment: Alignment.centerRight,
                                    icon: Icon(Icons.close, size: 18),
                                    onPressed: () => NotificationService()
                                        .deleteNotificationData(
                                            notificationModel.timestamp)),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
        onTap: () => {
              if (notificationModel.postId == null)
                {
                  //nextScreen(context, CustomNotificationDeatils(notificationModel: notificationModel));
                }
              else
                {
                  //nextScreen(context, PostNotificationDetails(postID: notificationModel.postId!));
                }
            });
  }
}
