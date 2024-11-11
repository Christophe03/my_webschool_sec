import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:my_webschool_sec/views/finance/finance_view.dart';
import 'package:my_webschool_sec/views/profil/profil_view.dart';
import 'package:my_webschool_sec/views/welcome/welcome_view.dart';

import '../../providers/notification_provider.dart';
import '../../services/notification_service.dart';
import '../note/note_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _initServies();
  }

  _initServies() async {
    Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      await NotificationService()
          .initFirebasePushNotification(context)
          .then((value) =>
              context.read<NotificationProvider>().handleFcmSubscribtion())
          .then((value) async {});
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _pageController.dispose();
    //HiveService().closeBoxes();
    super.dispose();
  }

  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      await SystemChannels.platform
          .invokeMethod<void>('SystemNavigator.pop', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => await _onWillPop(),
        child: Scaffold(
            bottomNavigationBar: _bottomNavigationBar(),
            body: PageView(
                controller: _pageController,
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                children: const <Widget>[
                  WelcomeView(),
                  NoteView(),
                  FinanceView(),
                  ProfilView(),
                ])));
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) => onTabTapped(index),
      currentIndex: _currentIndex,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 25,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: const Icon(Icons.home), label: 'home'.tr()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.format_list_numbered_rtl),
            label: 'notes'.tr()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on), label: 'finances'.tr()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person), label: 'profil'.tr()),
      ],
    );
  }
}
