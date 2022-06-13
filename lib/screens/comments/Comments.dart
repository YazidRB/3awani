import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/comments/CommentCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comments extends StatefulWidget {
  final snap;
  Comments({Key? key, required this.snap}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController textEditingControllerComment =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingControllerComment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Comments',
          style: GoogleFonts.quicksand(
              color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postID'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Colors.black, backgroundColor: Colors.white),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  CommentCard(snap: snapshot.data!.docs[index].data()),
            );
          }
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: profImage == null
                  ? NetworkImage(
                      'https://i1.sndcdn.com/avatars-000469982322-c5b8n9-t500x500.jpg')
                  : NetworkImage(profImage!),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 8.0),
                child: TextField(
                  controller: textEditingControllerComment,
                  decoration: InputDecoration(
                      hintText: 'add a comment',
                      hintStyle: GoogleFonts.quicksand(
                          color: Colors.black, fontSize: 14)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FireStoreFunctions().postComment(
                    widget.snap['postID'],
                    textEditingControllerComment.text,
                    uid!,
                    userName!,
                    profImage!);

                setState(() {
                  textEditingControllerComment.text = "";
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text('Post',
                    style: GoogleFonts.quicksand(
                        color: Colors.blueAccent, fontSize: 18)),
              ),
            )
          ],
        ),
      )),
    );
  }
}
