import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HelpProfileSignUp extends StatefulWidget {
  HelpProfileSignUp({Key? key}) : super(key: key);

  @override
  State<HelpProfileSignUp> createState() => _HelpProfileSignUpState();
}

class _HelpProfileSignUpState extends State<HelpProfileSignUp> {
  String? phone;
  final fsPhone = GlobalKey<FormState>();
  final fsPlace = GlobalKey<FormState>();
  final fsRealName = GlobalKey<FormState>();

  @override
  String? place;
  String? realName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(
              "Upload an image so poeple knows \n you easilly",
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
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.pngkey.com/png/detail/115-1150152_default-profile-picture-avatar-png-green.png'),
                        radius: 90,
                      ),
                      Positioned(
                          bottom: 13,
                          left: 128,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 42,
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
                        fontSize: 21, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: fsPlace,
              child: TextFormField(
                onSaved: (newValue) {
                  if (newValue != null) place = newValue;
                },
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    hintText: "Where do you live ? (optionel) ",
                    hintStyle: GoogleFonts.quicksand(fontSize: 21)),
              ),
            ),
            SizedBox(
              height: 30,
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
                    hintStyle: GoogleFonts.quicksand(fontSize: 21)),
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
              height: 25,
            ),
            Container(
              height: 40,
              child: GredientButton(
                onPressed: () {
                  if (fsPhone.currentState!.validate()) {
                    fsPhone.currentState!.save();
                    fsPlace.currentState!.save();
                    fsRealName.currentState!.save();
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'phone': phone,
                      'place': place,
                      'realName': realName
                    });
                    globals.phone = phone;
                    globals.realName = realName;
                    globals.place = place;

                    Navigator.of(context)
                        .pushReplacementNamed('HelpCategories');
                  }
                },
                splashColor: Color.fromARGB(255, 194, 193, 193),
                colors: [
                  primaryColor,
                  primaryColor,
                ],
                title: "Next",
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
