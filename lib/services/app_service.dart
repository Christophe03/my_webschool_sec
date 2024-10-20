import 'dart:io';

import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:reading_time/reading_time.dart';

class AppService {
  Future<bool?> checkInternet() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        internet = true;
      }
    } on SocketException catch (_) {
      // print('not connected');
      internet = false;
    }
    return internet;
  }

  // Future openLink(context, String url) async {
  //   final uri = Uri.parse(url);
  //   if (await urlLauncher.canLaunchUrl(uri)) {
  //     urlLauncher.launchUrl(uri);
  //   } else {
  //     openToast1(context, "Can't launch the url");
  //   }
  // }

  // Future openEmailSupport(context) async {
  //   final Uri uri = Uri(
  //     scheme: 'mailto',
  //     path: Config().supportEmail,
  //     query:
  //         'subject=About ${Config().appName}&body=', //add subject and body here
  //   );

  //   if (await urlLauncher.canLaunchUrl(uri)) {
  //     await urlLauncher.launchUrl(uri);
  //   } else {
  //     openToast1(context, "Can't open the email app");
  //   }
  // }

  // Future openLinkWithCustomTab(BuildContext context, String url) async {
  //   try {
  //     await FlutterWebBrowser.openWebPage(
  //       url: url,
  //       customTabsOptions: CustomTabsOptions(
  //         colorScheme: context.read<ThemeBloc>().darkTheme!
  //             ? CustomTabsColorScheme.dark
  //             : CustomTabsColorScheme.light,
  //         //addDefaultShareMenuItem: true,
  //         instantAppsEnabled: true,
  //         showTitle: true,
  //         urlBarHidingEnabled: true,
  //       ),
  //       safariVCOptions: SafariViewControllerOptions(
  //         barCollapsingEnabled: true,
  //         dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
  //         modalPresentationCapturesStatusBarAppearance: true,
  //       ),
  //     );
  //   } catch (e) {
  //     openToast1(context, 'Cant launch the url');
  //     debugPrint(e.toString());
  //   }
  // }

  // Future launchAppReview(context) async {
  //   final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
  //   await LaunchReview.launch(
  //       androidAppId: sb.packageName,
  //       iOSAppId: Config().iOSAppId,
  //       writeReview: false);
  //   if (Platform.isIOS) {
  //     if (Config().iOSAppId == '000000') {
  //       openToast1(
  //           context, 'The iOS version is not available on the AppStore yet');
  //     }
  //   }
  // }

  // static getYoutubeVideoIdFromUrl(String videoUrl) {
  //   print("YB=URL=" + videoUrl);
  //   late String? vId = "";
  //   if (!videoUrl.contains("live")) {
  //     vId = YoutubePlayer.convertUrlToId(videoUrl, trimWhitespaces: true);
  //   } else {
  //     vId = videoUrl.replaceAll("https://www.youtube.com/live/", "");
  //   }
  //   print("YB=ID=" + vId!);
  //   return vId;
  // }

  static getNormalText(String text) {
    return HtmlUnescape().convert(parse(text).documentElement!.text);
  }

  static getReadingTime(String text) {
    var reader = readingTime(getNormalText(text));
    return reader.msg;
  }

  // static CustomRenderMatcher videoMatcher() =>
  //     (context) => context.tree.element?.localName == 'video';
  // static CustomRenderMatcher iframeMatcher() =>
  //     (context) => context.tree.element?.localName == 'iframe';
  // static CustomRenderMatcher imageMatcher() =>
  //     (context) => context.tree.element?.localName == 'img';
}
