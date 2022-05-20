import 'package:aawani/resource/Globals.dart';
import 'package:aawani/widgets/PostCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({Key? key}) : super(key: key);

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
              onPressed: () {},
              icon: Icon(
                Icons.send_rounded,
                color: Colors.black,
                size: 32,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard(
              snap: snapshot.data!.docs[index].data(),
              uid: uid,
            ),
          );
        },
      ),
    );
  }
}
