import 'dart:io';
import 'dart:typed_data';

import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HelpProfileSignUp extends StatefulWidget {
  HelpProfileSignUp({Key? key}) : super(key: key);

  @override
  State<HelpProfileSignUp> createState() => _HelpProfileSignUpState();
}

class _HelpProfileSignUpState extends State<HelpProfileSignUp> {
  String? phone;
  Uint8List? filee;
  String profImage = 'null';
  final fsPhone = GlobalKey<FormState>();
  final fsRealName = GlobalKey<FormState>();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  XFile? xfile;

  @override
  String? realName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), child: SignUpAppBar()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(
              "Upload an image so poeple knows you easilly",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                  fontSize: 21,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                  child: Stack(
                    children: [
                      filee == null
                          ? CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/default-avatar.png'),
                              radius: 50)
                          : CircleAvatar(
                              backgroundImage: MemoryImage(filee!),
                              radius: 50,
                            ),
                      Positioned(
                          bottom: -7,
                          left: 62,
                          child: IconButton(
                              onPressed: () async => await selectImage(context),
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 30,
                              )))
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            Expanded(child: Container()),
            Form(
              key: fsPhone,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'please enter your phone number';
                  return null;
                },
                onSaved: (newValue) {
                  phone = newValue;
                },
                keyboardType: TextInputType.phone,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: GoogleFonts.quicksand(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Form(
              key: fsRealName,
              child: TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) realName = newValue;
                },
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    hintText: "Your Real Name (optionel) ",
                    hintStyle: GoogleFonts.quicksand(fontSize: 15)),
              ),
            ),
            Expanded(child: Container()),
            Text('6/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 6,
              size: 8,
              padding: 0,
              selectedColor: primaryColor,
              unselectedColor: Colors.grey,
              roundedEdges: Radius.circular(10),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: GredientButton(
                onPressed: () async {
                  if (fsPhone.currentState!.validate()) {
                    fsPhone.currentState!.save();
                    fsRealName.currentState!.save();

                    if (filee != null) {
                      final storage = FirebaseStorage.instance.ref();
                      final picRef = storage
                          .child('profImage')
                          .child(FirebaseAuth.instance.currentUser!.uid);
                      UploadTask uploadTask = picRef.putData(filee!);
                      final snap = await uploadTask;
                      profImage = await snap.ref.getDownloadURL();
                    }

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'profImage': profImage,
                      'phone': phone,
                      'realName': realName,
                      'uid': auth.currentUser!.uid
                    });

                    globals.phone = phone;
                    globals.realName = realName;
                    globals.profImage = filee != null
                        ? profImage
                        : "assets/images/default-avatar.png";

                    Navigator.of(context)
                        .pushReplacementNamed('HelpCategories');
                  }
                },
                splashColor: Color.fromARGB(255, 0, 0, 0),
                colors: [
                  primaryColor,
                  primaryColor,
                ],
                title: "Next",
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Chose picture from'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Camera'),
                onPressed: () async {
                  xfile =
                      await ImagePicker().pickImage(source: ImageSource.camera);

                  setState(() async {
                    if (xfile != null) {
                      filee = await chang(xfile!);
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Gallery'),
                onPressed: () async {
                  xfile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  final file = await chang(xfile!);
                  setState(() {
                    if (file != null) {
                      filee = file;
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<String> uploadProfImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference storageRef = storage.ref().child(childName).child(globals.uid!);

    UploadTask uploadTask = storageRef.putData(file);

    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }

  chang(XFile xFile) async {
    return await File(xfile!.path).readAsBytes();
  }
}
