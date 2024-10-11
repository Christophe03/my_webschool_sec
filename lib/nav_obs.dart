import 'package:flutter/material.dart';

class NavObs extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // print('didPoproute=${route.settings.name}');
    // if (previousRoute is MaterialPageRoute) {
    //   print('didPoppreviousRoute=${previousRoute.settings.name}');
    // }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    // print('didPushroute=${route.settings.name}');
    // if (previousRoute is MaterialPageRoute) {
    //   print('didPushpreviousRoute=${previousRoute.settings.name}');
    // }
  }
  // @override
  // void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
  //   if (previousRoute.settings.name == '/detail') {
  //     // If returning from the 'DetailScreen', trigger a rebuild
  //     if (previousRoute is MaterialPageRoute) {
  //      // (previousRoute.builder as DetailScreenBuilder).triggerRebuild();
  //     }
  //   }
  // }
}
