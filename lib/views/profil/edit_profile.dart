import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../providers/internet_provider.dart';
import '../../providers/sign_in_provider.dart';
import '../../utils/snacbar.dart';

class EditProfile extends StatefulWidget {
  final String? uid;
  final String? name;

  const EditProfile({super.key, @required this.uid, @required this.name});

  @override
  _EditProfileState createState() => _EditProfileState(uid ?? '', name ?? '');
}

class _EditProfileState extends State<EditProfile> {
  _EditProfileState(this.uid, this.name);
  String? uid;
  String? name;
  String? imageUrl = "";
  File? imageFile;
  String? fileName;
  bool loading = false;

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var nameCtrl = TextEditingController();

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    var imagepicked = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    if (imagepicked != null) {
      setState(() {
        imageFile = File(imagepicked.path);
        fileName = (imageFile!.path);
      });
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory(); // 1
      String path = appDocumentsDirectory.path;
      await imageFile!.copy('$path/profil.png');
    } else {
      if (kDebugMode) {
        print('No image selected!');
      }
    }
  }

  Future uploadPicture() async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('users/${widget.uid}');
      UploadTask uploadTask = storageReference.putFile(imageFile!);
      await uploadTask.whenComplete(() async {
        var url = await storageReference.getDownloadURL();
        setState(() {
          imageUrl = url.toString();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() => loading = false);
    }
  }

  handleUpdateData() async {
    final InternetProvider ib = context.read<InternetProvider>();
    final sb = context.read<SignInProvider>();
    await ib.checkInternet();
    if (ib.hasInternet == false) {
      openSnacbar(context, 'no_internet'.tr());
    } else {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        setState(() => loading = true);

        imageFile == null
            ? await sb
                .updateUserProfile(widget.uid!, nameCtrl.text, imageUrl ?? '')
                .then((value) {
                openSnacbar(context, 'updated_successfully'.tr());
                setState(() => loading = false);
              })
            : await uploadPicture().then((value) => sb
                    .updateUserProfile(
                        widget.uid!, nameCtrl.text, imageUrl ?? '')
                    .then((_) {
                  openSnacbar(context, 'updated_successfully'.tr());
                  setState(() => loading = false);
                }));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameCtrl.text = name ?? '';
  }

  Future<String> checkPhoto() async {
    String path = "";
    await Future.delayed(const Duration(seconds: 0));
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    path = appDocumentsDirectory.path;
    bool pfExists = await File('$path/profil.png').exists();
    if (pfExists) {
      return '$path/profil.png';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('edit_profile').tr(),
        ),
        body: FutureBuilder<String>(
          future: checkPhoto(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                return ListView(
                  padding: const EdgeInsets.all(25),
                  children: <Widget>[
                    InkWell(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey[300],
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey[800]!),
                              color: Colors.grey[500],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageFile != null
                                      ? FileImage(imageFile!)
                                      : imageUrl != ""
                                          ? CachedNetworkImageProvider(
                                              imageUrl!) as ImageProvider
                                          : snapshot.data != ''
                                              ? FileImage(File(snapshot.data!))
                                              : FileImage(File(
                                                  Config().defaultAppIcon)),
                                  fit: BoxFit.cover)),
                          child: const Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.edit,
                                size: 30,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      onTap: () {
                        pickImage();
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                        key: formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'enter_new_name'.tr(),
                          ),
                          controller: nameCtrl,
                          validator: (value) {
                            if (value!.isEmpty) return "Name can't be empty";
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            textStyle: MaterialStateProperty.resolveWith(
                                (states) =>
                                    const TextStyle(color: Colors.white))),
                        child: loading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : const Text(
                                'update_profile',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ).tr(),
                        onPressed: () {
                          handleUpdateData();
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ));
  }
}
