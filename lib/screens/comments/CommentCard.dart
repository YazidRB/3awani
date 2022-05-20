import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends StatefulWidget {
  CommentCard({Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i1.sndcdn.com/avatars-000469982322-c5b8n9-t500x500.jpg'),
            radius: 18,
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
                        text: 'yazid_rb',
                        style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'qsjdhqskjfhqjkshdfnjsf',
                        style: GoogleFonts.quicksand(color: Colors.grey))
                  ])),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      '23/05/2022',
                      style: GoogleFonts.quicksand(
                          color: Colors.grey, fontWeight: FontWeight.w400),
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
              iconSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
