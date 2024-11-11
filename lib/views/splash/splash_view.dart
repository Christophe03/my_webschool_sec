import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../providers/sign_in_provider.dart';
import '../../routes/routes.dart';
import '../../utils/constants_util.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  afterSplash() {
    final SignInProvider sb = context.read<SignInProvider>();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      sb.isSignedIn == true ? gotoHomeView() : gotoSignInView();
      //Navigator.of(context).pushReplacementNamed(Routes.home);
    });
  }

  gotoHomeView() {
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  gotoSignInView() {
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  gotoSignUpView() {
    Navigator.of(context).pushReplacementNamed(Routes.signup);
  }

  @override
  void initState() {
    afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: double.infinity,
        color: kColorPrimary,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/splash.png',
                  fit: BoxFit.fill,
                  height: 120,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            RichText(
                text: TextSpan(
              text: Config().appName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            )),
          ])),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: 150,
                  height: 2,
                  child: const LinearProgressIndicator(
                    backgroundColor: kColorPrimary,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
