import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserEmail extends StatelessWidget {
  UserEmail({Key? key}) : super(key: key);

  final fs = GlobalKey<FormState>();
  String? mail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Please your email?',
                style: GoogleFonts.quicksand(fontSize: 34),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Form(
              key: fs,
              child: TextFormField(
                onSaved: (newVal) {
                  mail = newVal;
                },
                validator: (val) {
                  if (val == null) return 'you need to enter the name';
                  if (val.length <= 2)
                    return 'your email cant be less than 6 letters';
                  if (!val.contains('@'))
                    return 'invalide email';
                  else
                    return null;
                },
                cursorColor: primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Your Email',
                    hintStyle: GoogleFonts.quicksand(fontSize: 21)),
              ),
            ),
            Expanded(child: Container()),
            Text('3/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 3,
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
                  if (fs.currentState!.validate()) {
                    fs.currentState!.save();

                    globals.email = mail;
                    Navigator.of(context).pushReplacementNamed('Pass');
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
