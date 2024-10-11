// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../providers/sign_in_provider.dart';
import '../../routes/routes.dart';
import '../../utils/constants_util.dart';
import '../../widgets/labeled_text_form_field.dart';
import '../../widgets/wave_header.dart';
import 'widgets/email_login.dart';
import 'widgets/social_login_widget.dart';

class LoginView extends StatefulWidget {
  final String? tag;
  const LoginView({super.key, this.tag});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _hasInternet = false;
  bool showProgress = false;
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RoundedLoadingButtonController _emailButtonController =
      RoundedLoadingButtonController();

  bool signInStart = false;
  bool signInComplete = false;

  String? email;
  String? pass;

  handleGoogleSignIn() async {
    // final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    // await AppService().checkInternet().then((hasInternet) async {
    //   if (hasInternet == false) {
    //     openSnacbar(context, 'check your internet connection!'.tr());
    //   } else {
    //     await sb.signInWithGoogle().then((_) {
    //       if (sb.hasError == true) {
    //         openSnacbar(context, 'something is wrong. please try again.'.tr());
    //         _googleController.reset();
    //       } else {
    //         sb.checkUserExists().then((value) {
    //           if (value == true) {
    //             sb
    //                 .getUserDatafromFirebase(sb.uid)
    //                 .then((value) => sb.guestSignout())
    //                 .then((value) => sb
    //                     .saveDataToSP()
    //                     .then((value) => sb.setSignIn().then((value) {
    //                           _googleController.success();
    //                           handleAfterSignIn();
    //                         })));
    //           } else {
    //             sb.getTimestamp().then((value) => sb
    //                 .saveToFirebase()
    //                 .then((value) => sb.increaseUserCount())
    //                 .then((value) => sb.guestSignout())
    //                 .then((value) => sb
    //                     .saveDataToSP()
    //                     .then((value) => sb.setSignIn().then((value) {
    //                           _googleController.success();
    //                           handleAfterSignIn();
    //                         }))));
    //           }
    //         });
    //       }
    //     });
    //   }
    // });
  }
  handleSignInwithemailPassword() async {
    if (formKey.currentState!.validate()) {
      final SignInProvider sb =
          Provider.of<SignInProvider>(context, listen: false);

      formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          _hasInternet = true;
        } else {
          _hasInternet = false;
        }
      } on SocketException catch (_) {
        _hasInternet = false;
      }

      if (_hasInternet == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('no.internet'.tr()),
        ));
      } else {
        setState(() {
          signInStart = true;
          showProgress = true;
        });

        sb.signInwithEmailPassword(email, pass).then((uid) async {
          if (sb.hasError == false) {
            final userHive = Hive.box(hivedb);
            userHive.put('uid', uid);
            sb.saveDataToHive(uid).then((value) => sb.setSignIn().then((value) {
                  setState(() {
                    signInComplete = true;
                    showProgress = false;
                  });
                  afterSignIn();
                }));
          } else {
            setState(() {
              signInStart = false;
              showProgress = false;
            });
            if (sb.errorMessage.contains('INVALID_LOGIN_CREDENTIALS')) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('error.login'.tr()),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(sb.errorMessage),
              ));
            }
          }
        });
      }
    } else {
      _emailButtonController.reset();
      if (kDebugMode) {
        print('error');
      }
    }
  }

  afterSignIn() {
    if (widget.tag == null) {
      Navigator.of(context).popAndPushNamed(Routes.home);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                      child: Column(children: <Widget>[
                    WaveHeader(
                      title: 'welcome to'.tr(),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 38),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    child: SizedBox(
                                      height: 10,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'sign_in'.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                      key: formKey,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                LabeledTextFormField(
                                                  title: 'email'.tr(),
                                                  controller: _emailController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  hintText: 'votre.email'.tr(),
                                                  validator: (value) => value!
                                                          .isEmpty
                                                      ? "error.email.required"
                                                          .tr()
                                                      : null,
                                                  onChanged: (value) =>
                                                      email = value!.trim(),
                                                ),
                                                LabeledTextFormField(
                                                  title: 'password'.tr(),
                                                  controller:
                                                      _passwordController,
                                                  obscureText: true,
                                                  validator: (value) => value!
                                                          .isEmpty
                                                      ? 'error.pawword.required'
                                                          .tr()
                                                      : null,
                                                  onChanged: (value) =>
                                                      pass = value!,
                                                  hintText: '* * * * * *',
                                                  padding: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(Routes
                                                                .forgotPassword);
                                                      },
                                                      child: Text(
                                                        'forgot_yout_password'
                                                            .tr(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]))),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: kColorPrimary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      height: 45,
                                      child: showProgress == true
                                          ? const Center(
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: kColorLight,
                                                  )),
                                            )
                                          : EmailLogin(
                                              controller:
                                                  _emailButtonController,
                                              onTap:
                                                  handleSignInwithemailPassword,
                                            )),
                                  //const LoginFooter(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // if (Platform.isAndroid)
                                  //   SocialLoginWidget(
                                  //     onTap: handleGoogleSignIn,
                                  //   ),
                                  const Expanded(
                                    child: SizedBox(
                                      height: 20,
                                    ),
                                  ),
                                ]))),
                  ]))));
        }));
  }
}
