import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserName extends StatelessWidget {
  @override
  final fs = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              child: Text(
                'Chose a unique name',
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
                  globals.userName = newValue!;
                },
                validator: (val) {
                  if (val == null) return 'you need to enter the name';
                  if (val.length <= 2)
                    return 'your name cant be less than 2 letters';
                  else
                    return null;
                },
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: GoogleFonts.quicksand(fontSize: 21)),
              ),
            ),
            Expanded(child: Container()),
            Text('2/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 2,
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

                    Navigator.of(context).pushReplacementNamed('UserEmail');
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
