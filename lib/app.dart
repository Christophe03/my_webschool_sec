import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/theme_model.dart';
import 'nav_obs.dart';
import 'providers/internet_provider.dart';
import 'providers/news_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/sign_in_provider.dart';
import 'routes/route_generator.dart';
import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InternetProvider>(
            create: (context) => InternetProvider()),
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider()),
        ChangeNotifierProvider<NewsProvider>(
            create: (context) => NewsProvider()),
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        initialRoute: Routes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [NavObs()],
        theme: ThemeModel().greenMode,
        // darkTheme: ThemeModel().darkMode,
        darkTheme: ThemeModel().greenMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
