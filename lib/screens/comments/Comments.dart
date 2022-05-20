import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/screens/comments/CommentCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comments extends StatefulWidget {
  final snap;
  Comments({Key? key, required this.snap}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
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
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i1.sndcdn.com/avatars-000469982322-c5b8n9-t500x500.jpg'),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'add a comment',
                      hintStyle: GoogleFonts.quicksand(
                          color: Colors.black, fontSize: 16)),
                ),
              ),
            ),
            InkWell(
              onTap: () async => await FireStoreFunctions().addComment(
                  widget.snap['postID'],
                  widget.snap['text'],
                  'https://i1.sndcdn.com/avatars-000469982322-c5b8n9-t500x500.jpg'),
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
