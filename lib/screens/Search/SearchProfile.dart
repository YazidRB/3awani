import 'package:aawani/screens/messages/ChatDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchProfile extends StatefulWidget {
  final snap;
  const SearchProfile({Key? key, required this.snap}) : super(key: key);

  @override
  _SearchProfileState createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile>
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
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.grey,
                    iconSize: 25,
                  ),
                  widget.snap["realName"] != null
                      ? Text(widget.snap["realName"]!,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 20,
                          ))
                      : Text(widget.snap["userName"]!,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 24,
                          )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.0),
            widget.snap["profImage"] == null
                ? CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/default-avatar.png'))
                : CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap["profImage"]!),
                    radius: 70.0,
                  ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "@${widget.snap["userName"]}",
                  style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 13,
                ),
                widget.snap["helpType"] == 'needHelp'
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
                      widget.snap["phone"]!,
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
                          child: widget.snap["categories"]['money']!
                              ? Icon(
                                  Icons.attach_money_outlined,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: widget.snap["categories"]['clothes']!
                              ? Icon(
                                  Icons.checkroom,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: widget.snap["categories"]['food']!
                              ? Icon(
                                  Icons.fastfood_rounded,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: widget.snap["categories"]['physical']!
                              ? Icon(
                                  Icons.accessibility,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: widget.snap["categories"]['drugs']!
                              ? Icon(
                                  Icons.vaccines,
                                  color: Colors.green,
                                )
                              : Text(''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: widget.snap["categories"]['others']!
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Help",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140.0, 55.0),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                OutlinedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetails(
                            receiver: widget.snap["uid"],
                            receiverPic: widget.snap["profImage"],
                            receiverName: widget.snap["userName"],
                          ),
                        ));
                  },
                  child: Icon(Icons.mail_outline_outlined),
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      fixedSize: Size(50.0, 60.0)),
                ),
                SizedBox(width: 50.0),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                )
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
