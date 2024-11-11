import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_webschool_sec/utils/toast_util.dart';

void launchURL(BuildContext context, String url) async {
  try {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: true,
      enableJavaScript: true,
      statusBarBrightness: Brightness.light,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
    // await launch(
    //   url,
    //   option: new CustomTabsOption(
    //     toolbarColor: Theme.of(context).backgroundColor,
    //     enableDefaultShare: true,
    //     enableUrlBarHiding: true,
    //     showPageTitle: true,
    //     animation: const CustomTabsAnimation(
    //       startEnter: 'android:anim/slide_in_right',
    //       startExit: 'android:anim/slide_out_left',
    //       endEnter: 'android:anim/slide_in_left',
    //       endExit: 'android:anim/slide_out_right',
    //     ),
    //     extraCustomTabs: <String>[
    //       // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
    //       'org.mozilla.firefox',
    //       // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
    //       'com.microsoft.emmx',
    //     ],
    //   ),
    // );
  } catch (e) {
    openToast1(context, 'Cant launch the url');
    debugPrint(e.toString());
  }
}
