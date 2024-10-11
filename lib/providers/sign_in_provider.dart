// import 'package:apple_sign_in/apple_sign_in.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
// import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants_util.dart';
import '../utils/string_util.dart';

class SignInProvider extends ChangeNotifier {
  SignInProvider() {
    checkSignIn();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final GoogleSignIn _googlSignIn = new GoogleSignIn();
  // final FacebookLogin _fbLogin = new FacebookLogin();
  final String defaultUserImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/ws-portail-sup.appspot.com/o/app%2Fprofil.png?alt=media&token=ff1fe0b7-0f2b-49ac-97c1-e2847dcbc980';
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String signInProvider = "";

  //String? _uid = '0vQ9ojXffMXxcGnhbd2I';
  //String get uid => _uid!;

  bool _isSignedIn = true;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String get errorCode => _errorCode!;

  String? _errorMessage;
  String get errorMessage => _errorMessage!;

  String? timestamp;

  // Future signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
  //   if (googleUser != null) {
  //     try {
  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       User userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;

  //       this._firstName = userDetails.displayName;
  //       this._email = userDetails.email;
  //       this._imageUrl = userDetails.photoURL;
  //       this._uid = userDetails.uid;
  //       this._signInProvider = 'google';

  //       _hasError = false;
  //       notifyListeners();
  //     } catch (e) {
  //       _hasError = true;
  //       _errorCode = e.toString();
  //       notifyListeners();
  //     }
  //   } else {
  //     _hasError = true;
  //     notifyListeners();
  //   }
  // }

  // Future signInwithFacebook() async {

  //     User currentUser;
  //     final FacebookLoginResult facebookLoginResult =  await _fbLogin.logIn(['email', 'public_profile']);
  //     if(facebookLoginResult.status == FacebookLoginStatus.cancelledByUser){
  //       _hasError = true;
  //       _errorCode = 'cancel';
  //       notifyListeners();
  //     } else if(facebookLoginResult.status == FacebookLoginStatus.error){
  //       _hasError = true;
  //       notifyListeners();
  //     } else{
  //       try {
  //         if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
  //         FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
  //         final AuthCredential credential = FacebookAuthProvider.credential(facebookAccessToken.token);
  //         final User user = (await _firebaseAuth.signInWithCredential(credential)).user;
  //         assert(user.email != null);
  //         assert(user.displayName != null);
  //         assert(!user.isAnonymous);
  //         assert(await user.getIdToken() != null);
  //         currentUser = _firebaseAuth.currentUser;
  //         assert(user.uid == currentUser.uid);

  //         this._firstName = user.displayName;
  //         this._email = user.email;
  //         this._imageUrl = user.photoURL;
  //         this._uid = user.uid;
  //         this._signInProvider = 'facebook';

  //         _hasError = false;
  //         notifyListeners();
  //     }
  //   } catch (e) {
  //       _hasError = true;
  //       _errorCode = e.toString();
  //       notifyListeners();
  //     }

  //   }
  // }

  // Future signInWithApple () async {

  //   final _firebaseAuth = FirebaseAuth.instance;
  //   final result = await AppleSignIn.performRequests(
  //       [AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])]);

  //   if(result.status == AuthorizationStatus.authorized){
  //     try
  //     {
  //       final appleIdCredential = result.credential;
  //       final oAuthProvider = OAuthProvider('apple.com');
  //       final credential = oAuthProvider.credential(
  //         idToken: String.fromCharCodes(appleIdCredential.identityToken),
  //         accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
  //       );
  //       final authResult = await _firebaseAuth.signInWithCredential(credential);
  //       final firebaseUser = authResult.user;

  //       this._uid = firebaseUser.uid;
  //       this._firstName = '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
  //       this._email = appleIdCredential.email ?? 'null';
  //       this._imageUrl = firebaseUser.photoURL ?? defaultUserImageUrl;
  //       this._signInProvider = 'apple';

  //       print(firebaseUser);
  //       _hasError = false;
  //       notifyListeners();

  //     }
  //     catch(e)
  //     {
  //       _hasError = true;
  //       _errorCode = e.toString();
  //       notifyListeners();
  //     }
  //   }
  //   else if (result.status == AuthorizationStatus.error)
  //   {
  //     _hasError = true;
  //     _errorCode = 'Appple Sign In Error! Please try_again';
  //     notifyListeners();
  //   }
  //   else if (result.status == AuthorizationStatus.cancelled)
  //   {
  //     _hasError = true;
  //     _errorCode = 'Sign In Cancelled!';
  //     notifyListeners();
  //   }

  // }

  Future<String> signUpwithEmailPassword(
      userName, userEmail, userPassword) async {
    try {
      final User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      ))
          .user!;
      signInProvider = 'email';
      _hasError = false;
      notifyListeners();
      return user.uid;
    } catch (e) {
      _hasError = true;
      // _errorCode = e.code;
      if (e.toString().contains('weak-password')) {
        _errorMessage = 'Le mot de passe doit comporter au moins 6 caractères';
      } else if (e.toString().contains('email-already-in-use')) {
        _errorMessage =
            "L'adresse e-mail est déjà utilisée par un autre compte";
      } else {
        _errorMessage = e.toString();
      }
      if (kDebugMode) {
        print('Caught error: $e');
      }
      notifyListeners();
      return '';
    }
  }

  Future signInwithEmailPassword(userEmail, userPassword) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      final User currentUser = _firebaseAuth.currentUser!;
      signInProvider = 'email';
      _hasError = false;
      notifyListeners();
      return currentUser.uid;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Caught error: $e');
      }
      notifyListeners();
    }
  }

  Future resetPassword(String email) async {
    try {
      if (!startsWithNumber(email)) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      }

      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Caught error: $e');
      }
      notifyListeners();
    }
  }

  Future<bool> checkUserExists(uid) async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snap.exists) {
      if (kDebugMode) {
        print('User Exists');
      }
      return true;
    } else {
      if (kDebugMode) {
        print('new user');
      }
      return false;
    }
  }

  Future saveToFirebase(String uid, String name, String phone, String email,
      String provider) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(uid);
    var userData = {
      'uid': uid,
      'name': name.toCapitalized(),
      'phone': phone,
      'email': email,
      'avatar': defaultUserImageUrl,
      'role': 'user',
      'provider': provider,
      'timestamp': timestamp,
      // 'loved items': [],
      // 'bookmarked items': []
    };
    await ref.set(userData);
  }

  Future getTimestamp() async {
    DateTime now = DateTime.now();
    timestamp = DateFormat('yyyyMMddHHmmss').format(now);
  }

  Future saveDataToHive(String uid) async {
    final userHive = Hive.box(hivedb);
    try {
      // print('ktag:uid=$uid');
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) async {
        userHive.put('uid', uid);
        userHive.put('sid', value['sid']);
        userHive.put('firstname', value['firstname']);
        userHive.put('lastname', value['lastname']);
        userHive.put('name', value['name']);
        userHive.put('phone', value['phone']);
        userHive.put('email', value['email']);
        userHive.put('avatar', value['avatar']);
        userHive.put('role', value['role']);
      });
      await FirebaseFirestore.instance
          .collection("structures")
          .doc(userHive.get('sid'))
          .get()
          .then((value) async {
        userHive.put('sname', value['name']);
        userHive.put('semail', value['email']);
        userHive.put('ssiteweb', value['siteweb']);
        userHive.put('scontact', value['contact']);
        userHive.put('sadresse', value['adresse']);
      });
      await FirebaseFirestore.instance
          .collection("students_" + userHive.get('sid'))
          .doc(userHive.get('uid'))
          .get()
          .then((value) async {
        userHive.put('etablissement', value['etablissement']);
        userHive.put('annee_acc', value['annee_acc']);
        userHive.put('formation', value['formation']);
        userHive.put('code', value['code']);
        userHive.put('formation', value['formation']);
        userHive.put('niveau', value['niveau']);
        userHive.put('prenom', value['prenom']);
        userHive.put('nom', value['nom']);
        userHive.put('sexe', value['sexe']);
        DateTime dateTime = value['date_naiss'].toDate();
        if (dateTime.day > 0) {
          userHive.put(
              'date_naiss', formatDateTime(dateTime, 'dd/MM/yyyy', null));
        } else {
          userHive.put('date_naiss', '');
        }

        userHive.put('lieu_naiss', value['lieu_naiss']);
        userHive.put('email', value['email']);
        userHive.put('tel1', value['tel1']);
        userHive.put('tel2', value['tel2']);
        userHive.put('ville', value['ville']);
        userHive.put('adresse', value['adresse']);
        Timestamp update_at = value['update_at'];
        userHive.put('update_at', update_at.millisecondsSinceEpoch);
      });
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Caught error: $e');
      }
      notifyListeners();
    }
  }

  Future getUserDatafromFirebase(String uid) async {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) async {
        var data = {
          'uid': value['uid'],
          'sid': value['sid'],
          'firstname': value['firstname'],
          'lastname': value['lastname'],
          'name': value['name'],
          'phone': value['phone'],
          'email': value['email'],
          'avatar': value['avatar'],
          'role': value['role'],
          'timestamp': value['timestamp']
        };

        //DatabaseManager.instance.updateUser(cuser);

        return data;
      });
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Caught error: $e');
      }
      notifyListeners();
    }
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    // print('_isSignedIn=$_isSignedIn');
    notifyListeners();
  }

  Future userSignout() async {
    if (signInProvider == 'apple') {
      //await _firebaseAuth.signOut();
    } else if (signInProvider == 'facebook') {
      //await _firebaseAuth.signOut();
      // await _fbLogin.logOut();
    } else if (signInProvider == 'email') {
      await _firebaseAuth.signOut();
    } else {
      //await _firebaseAuth.signOut();
      // await _googlSignIn.signOut();
    }
  }

  Future afterUserSignOut() async {
    if (kDebugMode) {
      print('logout');
    }
    await userSignout().then((value) async {
      await clearAllData();
      _isSignedIn = false;
      notifyListeners();
    });
  }

  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future updateUserProfile(String uid, String name, String image) async {
    bool hasInternet = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternet = true;
      } else {
        hasInternet = false;
      }
    } on SocketException catch (_) {
      hasInternet = false;
    }
    if (hasInternet) {
      final userHive = Hive.box(hivedb);
      userHive.put('name', name.toCapitalized());
      userHive.put('avatar', image);
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'name': name.toCapitalized(), 'avatar': image});
    }

    notifyListeners();
  }

  Future<int> getTotalUsersCount() async {
    const String fieldName = 'count';
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('item_count').doc('users_count');
    DocumentSnapshot snap = await ref.get();
    if (snap.exists == true) {
      int itemCount = snap[fieldName] ?? 0;
      return itemCount;
    } else {
      await ref.set({fieldName: 0});
      return 0;
    }
  }

  Future increaseUserCount() async {
    await getTotalUsersCount().then((int documentCount) async {
      await FirebaseFirestore.instance
          .collection('item_count')
          .doc('users_count')
          .update({'count': documentCount + 1});
    });
  }
}
