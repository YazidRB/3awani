import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/screens/Login/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aawani/resource/Globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  var listImage = [];
  int itemCount = 5;
  final fire = FirebaseAuth.instance.currentUser;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  globals.realName != null
                      ? Text(globals.realName!,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 24,
                          ))
                      : Text(globals.userName!,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 24,
                          )),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                    ListTile(
                                      leading: Icon(Icons.exit_to_app_sharp),
                                      title: Text("Sign out"),
                                      onTap: () async {
                                        await FireStoreFunctions().signOut();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.exit_to_app,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                172, 244, 67, 54)),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ])));
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.0),
            globals.profImage == null
                ? CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/default-avatar.png'),
                    radius: 70.0,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(globals.profImage!),
                    radius: 70.0,
                  ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "@${globals.userName}",
                  style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 13,
                ),
                globals.helpType == 'needHelp'
                    ? Icon(
                        Icons.hail_rounded,
                        size: 50,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.volunteer_activism_sharp,
                        size: 40,
                        color: Colors.green,
                      )
              ],
            ),
            SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 20.0),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone,
                            size: 32, color: Colors.black.withOpacity(0.3)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Number",
                          style: GoogleFonts.quicksand(
                              color: Colors.grey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      globals.phone!,
                      style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.hail_rounded,
                            size: 38, color: Colors.black.withOpacity(0.3)),
                        SizedBox(width: 15),
                        Text(
                          "Needs",
                          style: GoogleFonts.quicksand(
                              color: Colors.grey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      "2",
                      style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category,
                            size: 38, color: Colors.black.withOpacity(0.3)),
                        SizedBox(width: 15),
                        Text(
                          "Categories",
                          style: GoogleFonts.quicksand(
                              color: Colors.grey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: globals.categories['money']!
                              ? Icon(
                                  Icons.attach_money_outlined,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: globals.categories['clothes']!
                              ? Icon(
                                  Icons.checkroom,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: globals.categories['food']!
                              ? Icon(
                                  Icons.fastfood_rounded,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: globals.categories['physical']!
                              ? Icon(
                                  Icons.accessibility,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: globals.categories['drugs']!
                              ? Icon(
                                  Icons.vaccines,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: globals.categories['others']!
                              ? Icon(
                                  Icons.interests,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(width: 20.0),
              ],
            ),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TabBar(
                  isScrollable: true,
                  controller: tabController,
                  indicator: BoxDecoration(borderRadius: BorderRadius.zero),
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black26,
                  onTap: (tapIndex) {
                    setState(() {
                      selectedIndex = tapIndex;
                    });
                  },
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  tabs: [
                    Tab(
                        icon: Icon(
                      Icons.hail_rounded,
                      size: 40,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.add_business_sharp,
                      size: 40,
                    )),
                    Tab(
                      icon: Icon(
                        Icons.info_outline,
                        size: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              height: (itemCount / 3).ceil() * 250 + 50,
              child: TabBarView(
                controller: tabController,
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250.0, crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      );
                    },
                    itemCount: itemCount,
                  ),
                  Center(
                    child: Text("You don't have any videos"),
                  ),
                  Center(
                    child: Text("You don't have any tagged"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
