import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/notification_model.dart';
import '../../../services/app_service.dart';
import '../../../utils/html_body.dart';

class CustomNotificationDeatils extends StatelessWidget {
  const CustomNotificationDeatils({Key? key, required this.notificationModel})
      : super(key: key);

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    //final String dateTime = Jiffy(notificationModel.date).fromNow();
    final String dateTime = 'eee';
    return Scaffold(
      appBar: AppBar(
        title: const Text('notification details').tr(),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.clock,
                  size: 16,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  dateTime,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppService.getNormalText(notificationModel.title!),
              style: const TextStyle(
                fontFamily: 'Manrope',
                wordSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            HtmlBodyWidget(
                content: notificationModel.description!,
                isVideoEnabled: true,
                isimageEnabled: true,
                isIframeVideoEnabled: true),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
