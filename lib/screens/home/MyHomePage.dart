import 'package:aawani/resource/Colors.dart';
import 'package:aawani/screens/Category/CategoryChose.dart';
import 'package:aawani/screens/Search/Search.dart';
import 'package:aawani/screens/addPost/addPost.dart';
import 'package:aawani/screens/profile/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

PageController controller = PageController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  int page = 0;
  List<Widget> listWidget = [
    CategoryChose(),
    Text('explore'),
    AddPost(),
    Search(),
    ProfilePage()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GNav(
              rippleColor: Colors.grey[800]
                  as Color, // tab button ripple color when pressed
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(
                  color: Colors.black, width: 1), // tab button border
              textStyle: GoogleFonts.quicksand(),
              selectedIndex: page,
              onTabChange: (val) {
                setState(() {
                  page = val;
                });
              },
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 430), // tab animation duration
              gap: 2, // the tab button gap between icon and text
              color: Colors.grey[800], // unselected icon color
              activeColor: primaryColor, // selected icon and text color
              iconSize: 17.4, // tab button icon size
              padding: EdgeInsets.symmetric(
                  horizontal: 4, vertical: 3), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                  onPressed: () {
                    setState(() {
                      page = 0;
                    });
                  },
                ),
                GButton(
                  icon: Icons.map_rounded,
                  text: 'Map',
                  onPressed: () {
                    page = 1;
                  },
                ),
                GButton(
                  icon: Icons.add_circle_outline_outlined,
                  text: 'Add Post',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ]),
        ),
        body: Container(child: listWidget.elementAt(page)));
  }
}
