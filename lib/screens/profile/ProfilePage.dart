import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/screens/Login/Login.dart';
import 'package:aawani/screens/addPost/PostUrl.dart';
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
                                      leading: globals.suc
                                          ? Icon(Icons.phonelink_lock_outlined)
                                          : Icon(Icons.phone_iphone_rounded),
                                      title: globals.suc
                                          ? Text("Phone authentification : ON")
                                          : Text(
                                              "Phone authentification : OFF"),
                                      onTap: () async {
                                        globals.suc = !globals.suc;

                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({'suc': globals.suc});
                                        Navigator.of(context).pop();
                                      },
                                    ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  globals.profImage == null
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/icons/default-avatar.png'),
                          radius: 70.0,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(globals.profImage!),
                          radius: 70.0,
                        ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${globals.userName}",
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      globals.helpType != 'needHelp'
                          ? Icon(
                              Icons.back_hand,
                              size: 25,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.volunteer_activism_sharp,
                              size: 25,
                              color: Colors.green,
                            )
                    ],
                  ),
                ]),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20.0),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone,
                                    size: 22,
                                    color: Colors.black.withOpacity(0.3)),
                                SizedBox(
                                  width: 7,
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
                            SizedBox(height: 5.0),
                            Text(
                              globals.phone!,
                              style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "sexe",
                              style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: globals.sexe['men'] == true
                                      ? Icon(
                                          Icons.male,
                                          color: Colors.green,
                                        )
                                      : Text(''),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: globals.sexe['women'] == true
                                      ? Icon(
                                          Icons.female,
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
                  ],
                ),
              ],
            ),
            SizedBox(height: 60.0),
            Center(
              child: Text(
                "Your Posts",
                style: GoogleFonts.quicksand(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: (itemCount / 3).ceil() * 250 + 50,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .where('uid', isEqualTo: globals.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs
                        .where(
                            (element) => element.data()['uid'] == globals.uid)
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 150.0, crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostUrl(
                                        postId: snapshot.data!.docs[index]
                                            .data()['postID'],
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot.data!.docs[index]
                                      .data()['postUrl'])),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
