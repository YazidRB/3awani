import 'package:aawani/resource/Colors.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:flutter/material.dart';
import 'package:aawani/resource/Globals.dart' as globals;

import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserType extends StatefulWidget {
  UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  var society = false;
  var person = false;

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
              'Are you ... ?',
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
                          if (person) {
                            person = false;
                          } else {
                            person = true;
                            society = false;
                          }
                        });
                      },
                      size: 100,
                      circleSize: 100,
                      isLiked: person,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.person,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 100,
                        );
                      },
                    ),
                    Text(
                      'Person',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    LikeButton(
                      onTap: (isLiked) async {
                        setState(() {
                          if (society) {
                            society = false;
                          } else {
                            person = false;
                            society = true;
                          }
                        });
                      },
                      size: 100,
                      circleSize: 100,
                      isLiked: society,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.store_mall_directory_outlined,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 100,
                        );
                      },
                    ),
                    Text(
                      'Society',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Expanded(child: Container()),
            Text('1/7',
                style: GoogleFonts.quicksand(
                    fontSize: 19, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            StepProgressIndicator(
              totalSteps: 7,
              currentStep: 1,
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
                  if (person) {
                    globals.userType = 'P';
                    Navigator.of(context).pushReplacementNamed('UserName');
                  } else if (society) {
                    globals.userType = 'P';
                    Navigator.of(context).pushReplacementNamed('UserName');
                  } else
                    print('no type is selected');
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
