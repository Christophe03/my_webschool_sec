// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/sign_in_provider.dart';
import '../../routes/routes.dart';
import '../../utils/constants_util.dart';
import '../../widgets/labeled_text_form_field.dart';
import '../../widgets/wave_header.dart';
import '../login/widgets/social_login_widget.dart';
import 'widgets/footer_signup.dart';

class SignupView extends StatefulWidget {
  final String? tag;
  const SignupView({super.key, this.tag});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool _hasInternet = false;
  bool showProgress = false;
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool signUpStarted = false;
  bool signUpCompleted = false;

  String? email;
  String? name;
  String? pass;
  String phone = '';

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
    //         sb.().then((value) {
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
  handleSignUpwithEmailPassword() async {
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
          signUpStarted = true;
          showProgress = true;
        });
        email = "${phone.trim().split(" ").join("")}@gmail.com";
        sb.signUpwithEmailPassword(name, email, pass).then((_uid) async {
          var uid = _uid;
          final SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('uid', uid);
          if (sb.hasError == false) {
            await sb.getTimestamp().then((value) => sb
                .saveToFirebase(uid, name!, phone.trim().split(" ").join(""),
                    email!, 'email')
                .then((value) => sb.increaseUserCount())
                .then((value) => sb
                    .saveDataToHive(uid)
                    .then((value) => sb.setSignIn().then((value) {
                          setState(() {
                            signUpCompleted = true;
                            showProgress = false;
                          });
                          afterSignUp();
                        }))));
          } else {
            setState(() {
              signUpStarted = false;
              showProgress = false;
            });
            if (sb.errorMessage.contains('password is invalid')) {
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
      if (kDebugMode) {
        print('error');
      }
    }
  }

  afterSignUp() {
    if (widget.tag == null) {
      // nextScreenReplace(context, DonePage());
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
                      title: 'sign_up'.tr(),
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
                                      'create_an_account_to_get_started'.tr(),
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
                                                  title: 'last_name'.tr(),
                                                  controller: _nameController,
                                                  hintText: '',
                                                  validator: (value) =>
                                                      value!.isEmpty
                                                          ? 'error.name'.tr()
                                                          : null,
                                                  onChanged: (value) =>
                                                      name = value!,
                                                ),
                                                LabeledTextFormField(
                                                  title:
                                                      'numero_telephone'.tr(),
                                                  controller: _phoneController,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  hintText: '',
                                                  validator: (value) => value!
                                                          .isEmpty
                                                      ? "error.phone.required"
                                                          .tr()
                                                      : null,
                                                  onChanged: (value) =>
                                                      phone = value!,
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
                                                  padding: 20,
                                                ),
                                                LabeledTextFormField(
                                                  title:
                                                      'confirm_password'.tr(),
                                                  controller:
                                                      _confirmPasswordController,
                                                  obscureText: true,
                                                  validator: (value) =>
                                                      value! != pass
                                                          ? 'error.pawword.match'
                                                              .tr()
                                                          : null,
                                                  hintText: '* * * * * *',
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
                                          : TextButton(
                                              child: Text(
                                                'sign_up'.tr(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              onPressed: () async {
                                                handleSignUpwithEmailPassword();
                                              })),
                                  const SignupFooter(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (Platform.isAndroid)
                                    SocialLoginWidget(
                                      onTap: handleGoogleSignIn,
                                    ),
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
