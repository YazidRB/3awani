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

Map<String, bool> categories = {
  'food': false,
  'money ': false,
  'clothes': false,
  'physical': false,
  'drugs': false,
  'others': false
};

getProfileData() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  globals.uid = FirebaseAuth.instance.currentUser!.uid;
  globals.email = FirebaseAuth.instance.currentUser!.email;
  globals.phone = data['phone'];
  globals.place = data['place'];
  globals.realName = data['realName'];
  globals.userType = data['userType'];
  globals.userName = data['userName'];
  globals.categories['food'] = data['categories']['food'];
  globals.categories['money'] = data['categories']['money'];
  globals.categories['clothes'] = data['categories']['clothes'];
  globals.categories['physical'] = data['categories']['physical'];
  globals.categories['drugs'] = data['categories']['drugs'];
  globals.categories['others'] = data['categories']['others'];

  globals.helpType = data['userType'];
}

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
              'How can you help with now or in the future?',
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
                      isLiked: categories['food'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked)
                            categories['food'] = true;
                          else
                            categories['food'] = false;
                        });
                      },
                      size: 35,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.fastfood_outlined,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Food',
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
                      isLiked: categories['money'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked)
                            categories['money'] = true;
                          else
                            categories['money'] = false;
                        });
                      },
                      size: 35,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.attach_money_outlined,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'money',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LikeButton(
                      isLiked: categories['clothes'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked)
                            categories['clothes'] = true;
                          else
                            categories['clothes'] = false;
                        });
                      },
                      size: 35,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.checkroom,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Clothes',
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
                      isLiked: categories['physical'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked)
                            categories['physical'] = true;
                          else
                            categories['physical'] = false;
                        });
                      },
                      size: 35,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.accessibility,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Physical',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    LikeButton(
                      isLiked: categories['drugs'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked)
                            categories['drugs'] = true;
                          else
                            categories['drugs'] = false;
                        });
                      },
                      size: 35,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.vaccines,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Drugs',
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
                      isLiked: categories['others'],
                      onTap: (isLiked) async {
                        setState(() {
                          if (!isLiked)
                            categories['others'] = true;
                          else
                            categories['others'] = false;
                        });
                      },
                      size: 35,
                      circleSize: 50,
                      circleColor:
                          CircleColor(start: Colors.grey, end: primaryColor),
                      animationDuration: Duration(milliseconds: 300),
                      bubblesColor: BubblesColor(
                          dotPrimaryColor: primaryColor,
                          dotSecondaryColor: Colors.grey),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.interests,
                          color: isLiked ? primaryColor : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Text(
                      'Others',
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
                onPressed: () async {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'categories': categories});

                  await getProfileData();
                  Navigator.of(context).pushReplacementNamed("homePage");
                },
                splashColor: Color.fromARGB(255, 194, 193, 193),
                colors: [
                  primaryColor,
                  primaryColor,
                ],
                title: "Finish!",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
