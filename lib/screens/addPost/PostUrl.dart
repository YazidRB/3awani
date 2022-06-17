import 'package:aawani/resource/Globals.dart';
import 'package:aawani/widgets/PostCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostUrl extends StatefulWidget {
  final postId;
  PostUrl({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostUrl> createState() => _PostUrlState();
}

class _PostUrlState extends State<PostUrl> {
  Map<String, dynamic>? data;
  getSnap(String postId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('posts').doc(postId).get();

    setState(() {
      data = snapshot.data() as Map<String, dynamic>;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSnap(widget.postId);
  }

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
          title: Text('Post',
              style: GoogleFonts.quicksand(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
        ),
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PostCard(
                snap: data,
                uid: uid,
              ));
  }
}
