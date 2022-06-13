import 'package:aawani/resource/Colors.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HelpAddpost extends StatefulWidget {
  HelpAddpost({Key? key}) : super(key: key);

  @override
  State<HelpAddpost> createState() => _HelpAddpostState();
}

class _HelpAddpostState extends State<HelpAddpost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                'Add Your First Post ! what do you need ?',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                    color: Colors.grey,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                print("on Tab");
              },
              child: Container(
                  height: MediaQuery.of(context).size.height / 2.8,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 35),
                  child: Icon(
                    Icons.image,
                    size: 70,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(144, 158, 158, 158),
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            ),
            Container(
              child: TextFormField(
                decoration:
                    InputDecoration(hintText: "Descreption", hintMaxLines: 4),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('7/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 7,
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
                  Navigator.of(context).pushReplacementNamed('homePage');
                },
                splashColor: Color.fromARGB(255, 194, 193, 193),
                colors: [
                  primaryColor,
                  primaryColor,
                ],
                title: "Finish !",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
