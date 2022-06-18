import 'package:aawani/resource/Colors.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HelpCategories extends StatefulWidget {
  HelpCategories({Key? key}) : super(key: key);

  @override
  State<HelpCategories> createState() => _HelpCategoriesState();
}

Map<String, bool> sexe = {'men': false, 'women': false};

class _HelpCategoriesState extends State<HelpCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'What is your sexe?',
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LikeButton(
                      isLiked: sexe['men'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked) {
                            sexe['men'] = true;
                            sexe['women'] = false;
                          } else
                            sexe['men'] = false;
                        });
                      },
                      size: 60,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.male,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Men',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    LikeButton(
                      isLiked: sexe['women'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked) {
                            sexe['women'] = true;
                            sexe['men'] = false;
                          } else
                            sexe['women'] = false;
                        });
                      },
                      size: 60,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.female,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Women',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
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
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'sexe': sexe});

                  Navigator.of(context)
                      .pushReplacementNamed("HelpProfileSignUp");
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
