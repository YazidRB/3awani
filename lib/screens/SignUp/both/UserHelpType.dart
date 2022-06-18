import 'package:aawani/resource/Colors.dart';
import 'package:aawani/screens/SignUp/both/HelpCategories.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:aawani/resource/Globals.dart' as globals;

class UserHelpType extends StatefulWidget {
  UserHelpType({Key? key}) : super(key: key);

  @override
  State<UserHelpType> createState() => _UserHelpTypeState();
}

class _UserHelpTypeState extends State<UserHelpType> {
  var help = false;
  var needHelp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              'you here for ..',
              style: GoogleFonts.quicksand(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LikeButton(
                      onTap: (isLiked) async {
                        setState(() {
                          if (help) {
                            needHelp = false;
                          } else {
                            needHelp = false;
                            help = true;
                          }
                        });
                      },
                      size: 80,
                      circleSize: 80,
                      isLiked: help,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.volunteer_activism_sharp,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 60,
                        );
                      },
                    ),
                    Text(
                      'Help',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    LikeButton(
                      onTap: (isLiked) async {
                        setState(() {
                          if (needHelp) {
                            needHelp = false;
                          } else {
                            needHelp = true;
                            help = false;
                          }
                        });
                      },
                      size: 80,
                      circleSize: 80,
                      isLiked: needHelp,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.back_hand,
                          color: isLiked ? red : Colors.grey,
                          size: 60,
                        );
                      },
                    ),
                    Text(
                      'need help',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Expanded(child: Container()),
            Text('5/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 5,
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
                  if (help) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'helpType': 'help'});
                    globals.helpType = 'help';
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HelpCategories()));
                  }
                  if (needHelp) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'helpType': 'needHelp'});
                    globals.helpType = 'needHelp';

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HelpCategories()));
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
