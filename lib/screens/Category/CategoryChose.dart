import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/Category/CategoryTab.dart';
import 'package:aawani/screens/messages/ChatPage.dart';
import 'package:aawani/widgets/PostCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryChose extends StatelessWidget {
  const CategoryChose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Aawani',
              style: GoogleFonts.quicksand(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('lib/icons/default-avatar.png'),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                },
                icon:
                    Image.asset('lib/icons/icons8-email-send-96(-xxxhdpi).png'))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1,
                crossAxisCount: 2,
                children: [
                  CategoryTab(
                      iconCategory:
                          'lib/icons/icons8-hamburger-96(-xxxhdpi).png',
                      cat: "food"),
                  CategoryTab(
                    iconCategory: 'lib/icons/icons8-money-96(-xxxhdpi).png',
                    cat: "money ",
                  ),
                  CategoryTab(
                    iconCategory: 'lib/icons/icons8-clothes-64.png',
                    cat: "clothes",
                  ),
                  CategoryTab(
                    iconCategory: 'lib/icons/icons8-teenager-male-100.png',
                    cat: "physical",
                  ),
                  CategoryTab(
                    iconCategory: 'lib/icons/icons8-drugs-64.png',
                    cat: "drugs",
                  ),
                  CategoryTab(
                    iconCategory: 'lib/icons/icons8-categorize-48.png',
                    cat: "others",
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
