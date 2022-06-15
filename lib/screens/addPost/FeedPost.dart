import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/messages/ChatPage.dart';
import 'package:aawani/widgets/PostCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({Key? key, required this.cat}) : super(key: key);
  final cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
        ),
        title: Text('${cat} Posts',
            style: GoogleFonts.quicksand(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  snapshot.data!.docs[index].data()["category"][cat] == true
                      ? PostCard(
                          snap: snapshot.data!.docs[index].data(),
                          uid: uid,
                        )
                      : Container(),
            );
          }
        },
      ),
    );
  }
}
