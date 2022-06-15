import 'package:aawani/resource/Globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          widget.snap['profilePic'] == null
              ? CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/default-avatar.png"),
                  radius: 16,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['profilePic']!),
                  radius: 16,
                ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: widget.snap['userName'],
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    TextSpan(
                        text: "  ${widget.snap["text"]}",
                        style: GoogleFonts.quicksand(
                            color: Color.fromARGB(255, 77, 76, 76)))
                  ])),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 8),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_upward_outlined),
              color: Colors.black,
              iconSize: 19.5,
            ),
          )
        ],
      ),
    );
  }
}
