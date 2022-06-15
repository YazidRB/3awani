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
          centerTitle: false,
          title: Text('Aawani',
              style: GoogleFonts.quicksand(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
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
                icon: Icon(
                  Icons.send_rounded,
                  color: Colors.black,
                  size: 32,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  CategoryTab(
                      iconCategory: Icons.fastfood_outlined, cat: "food"),
                  CategoryTab(
                    iconCategory: Icons.money,
                    cat: "money ",
                  ),
                  CategoryTab(
                    iconCategory: Icons.checkroom,
                    cat: "clothes",
                  ),
                  CategoryTab(
                    iconCategory: Icons.accessibility,
                    cat: "physical",
                  ),
                  CategoryTab(
                    iconCategory: Icons.vaccines,
                    cat: "drugs",
                  ),
                  CategoryTab(
                    iconCategory: Icons.interests,
                    cat: "others",
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
