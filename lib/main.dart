import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_sec/app.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';
import 'utils/constants_util.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('fcm=background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(hivedb);
  await Hive.openBox(notificationTag);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(EasyLocalization(
    supportedLocales: const [Locale('fr'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('fr'),
    startLocale: const Locale('fr'),
    assetLoader: const JsonAssetLoader(),
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
}
