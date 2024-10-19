// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/utils/snacbar.dart';

import '../../routes/routes.dart';
import '../../utils/constants_util.dart';
import '../../utils/dialog.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PasswordView extends StatefulWidget {
  final String? tag;
  const PasswordView({super.key, this.tag});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  // final _emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailCtrl = TextEditingController();
  String? _email;

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  // handleRessetPassword() async {
  //   if (formKey.currentState!.validate()) {
  //     final SignInProvider sb =
  //         Provider.of<SignInProvider>(context, listen: false);

  //     formKey.currentState!.save();
  //     FocusScope.of(context).requestFocus(new FocusNode());

  //     try {
  //       final result = await InternetAddress.lookup('google.com');
  //       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //         _hasInternet = true;
  //       } else {
  //         _hasInternet = false;
  //       }
  //     } on SocketException catch (_) {
  //       _hasInternet = false;
  //     }

  //     if (_hasInternet == false) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('no.internet'.tr()),
  //       ));
  //     } else {
  //       setState(() {
  //         signInStart = true;
  //         showProgress = true;
  //       });
  //       email = phone.trim().split(" ").join("") + "@gmail.com";

  //       sb.resetPassword(email!).then((_) async {
  //         if (sb.hasError == false) {
  //           setState(() {
  //             signInComplete = true;
  //           });
  //           afterSignIn();
  //         } else {
  //           setState(() {
  //             signInStart = false;
  //             showProgress = false;
  //           });
  //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text(sb.errorMessage),
  //           ));
  //         }
  //       });
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('error');
  //     }
  //   }
  // }

  afterSignIn() {
    if (widget.tag == null) {
      // nextScreenReplace(context, DonePage());
      Navigator.of(context).popAndPushNamed(Routes.login);
    } else {
      Navigator.pop(context);
    }
  }

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      resetPassword(_email ?? '');
    } else {
      _btnController1.reset();
    }
  }

  String getErrorWithoutFirebasse(String error) {
    String message = error;
    if (error.contains("[firebase_auth/invalid-email]")) {
      message = "veuillez.verifier.votre.email";
    }
    //
    if (error.contains("[firebase_auth/user-not-found]")) {
      message = "l.adresse.email.n.est.pas.associer.a.un.compte";
    }
    //
    if (error.contains("[firebase_auth/wrong-password]")) {
      message = "mot.de.passe.incorrecte";
    }
    //
    if (error.contains("[firebase_auth/weak-password]")) {
      message = "le.mot.de.passe.doit.contenir.au.mins.6.caractetes";
    }
    //
    if (error.contains("[firebase_auth/email-already-in-use]")) {
      message = "un.compte.utilise.deja.cet.email";
    }
    return message.tr();
  }

  Future<void> resetPassword(String email) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
      _btnController1.success();
      openDialogWithDoubleClose(context, 'reset password'.tr(),
          'message sent to email'.tr(namedArgs: {'email': email}));
      // Navigator.pop(context);
    } catch (error) {
      _btnController1.reset();
      openSnacbar(
          context,
          getErrorWithoutFirebasse(error
              .toString())); // là j'ai changé error.code en error.string faudra voir si ca passe
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10),
                child: RichText(
                    text: TextSpan(
                  text: "mot de passe oublie".tr(),
                  style: const TextStyle(
                    color: kColorDark,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "entrer l'email associe a votre compte".tr(),
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'email'.tr(), labelText: 'votre.email'.tr()
                    //suffixIcon: IconButton(icon: Icon(Icons.email), onPressed: (){}),

                    ),
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.length == 0) return "Email can't be empty".tr();
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),

              RoundedLoadingButton(
                successIcon: Icons.done,
                failedIcon: Icons.error,
                // width: double.infinity,
                // width: double.infinity,
                height: 45,
                width: MediaQuery.of(context).size.width,
                elevation: 0,
                borderRadius: 0,
                color: kColorPrimary,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'envoyer'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))),
                controller: _btnController1,
                onPressed: () {
                  handleSubmit();
                },
              ),

              // Container(
              //   height: 45,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //           backgroundColor: MaterialStateProperty.resolveWith(
              //               (states) => Theme.of(context).primaryColor)),
              //       child: Text(
              //         'envoyer',
              //         style: TextStyle(
              //             fontSize: 16 / MediaQuery.of(context).textScaleFactor,
              //             color: Theme.of(context).primaryColorLight),
              //       ).tr(),
              //       onPressed: () {
              //         handleSubmit();
              //       }),
              // ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),

      // LayoutBuilder(
      //   builder: (BuildContext context, BoxConstraints viewportConstraints) {
      //     return SingleChildScrollView(
      //       child: ConstrainedBox(
      //         constraints: BoxConstraints(
      //           minHeight: viewportConstraints.maxHeight,
      //         ),
      //         child: IntrinsicHeight(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 38),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 // const Expanded(
      //                 //   child: SizedBox(
      //                 //     height: 80,
      //                 //   ),
      //                 // ),
      //                 Text(
      //                   'forgot_password'.tr(),
      //                   style: const TextStyle(
      //                     fontSize: 28,
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 30,
      //                 ),
      //                 Form(
      //                     key: formKey,
      //                     child: Padding(
      //                         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: <Widget>[
      //                             Text(
      //                               'numero_telephone'.tr(),
      //                               style: kInputTextStyle,
      //                             ),
      //                             CustomTextFormField(
      //                               controller: _emailController,
      //                               keyboardType: TextInputType.phone,
      //                               hintText: '',
      //                               validator: (value) => value!.isEmpty
      //                                   ? "error.phone.required".tr()
      //                                   : null,
      //                               onChanged: (value) => phone = value!,
      //                             ),
      //                             const SizedBox(
      //                               height: 35,
      //                             ),
      //                             ElevatedButton.icon(
      //                               icon: showProgress
      //                                   ? const CircularProgressIndicator()
      //                                   : const Icon(Icons.login),
      //                               label: Text(
      //                                 showProgress
      //                                     ? 'wait...'.tr()
      //                                     : 'reset_password'.tr(),
      //                                 style: const TextStyle(fontSize: 16),
      //                               ),
      //                               onPressed: showProgress
      //                                   ? null
      //                                   : handleRessetPassword,
      //                               style: ElevatedButton.styleFrom(
      //                                   fixedSize: const Size(300, 50),
      //                                   primary: kColorPrimary),
      //                             )
      //                           ],
      //                         ))),

      //                 // WidgetForgot(),
      //                 Center(
      //                   child: TextButton(
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                     child: Text(
      //                       'login'.tr(),
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .button!
      //                           .copyWith(fontSize: 12),
      //                     ),
      //                   ),
      //                 ),
      //                 const Expanded(
      //                   flex: 2,
      //                   child: SizedBox(
      //                     height: 20,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
