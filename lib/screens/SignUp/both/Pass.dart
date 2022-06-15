import 'package:aawani/resource/Colors.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aawani/resource/Globals.dart' as globals;

class Pass extends StatelessWidget {
  Pass({Key? key}) : super(key: key);
  final fs = GlobalKey<FormState>();
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            Container(
              child: Text(
                'Please make a Strong Password!',
                style: GoogleFonts.quicksand(fontSize: 34),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Form(
              key: fs,
              child: TextFormField(
                onSaved: (newValue) {
                  password = newValue;
                },
                validator: (val) {
                  if (val == null) return 'Password can\'t be empty';
                  if (val.length <= 6)
                    return 'your password is weak less than 6 letters';
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    hintText: 'Your Password',
                    hintStyle: GoogleFonts.quicksand(fontSize: 21)),
              ),
            ),
            Expanded(child: Container()),
            Text('4/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 4,
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
              child: GredientButton(
                onPressed: () async {
                  if (fs.currentState!.validate()) {
                    fs.currentState!.save();
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: globals.email!, password: password!);
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'userName': globals.userName,
                        'userType': globals.userType
                      });

                      Navigator.of(context)
                          .pushReplacementNamed('UserHelpType');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        //mail ussd ?
                      }
                    } catch (e) {
                      print(e);
                    }
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
          ],
        ),
      ),
    );
  }
}
