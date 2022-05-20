import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/comments/Comments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final snap;
  final uid;
  const PostCard({Key? key, required this.snap, required this.uid})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://i1.sndcdn.com/avatars-000469982322-c5b8n9-t500x500.jpg'),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.snap['userName'],
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: ['Report']
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ),
                                      )
                                      .toList())));
                    },
                    icon: Icon(Icons.more_vert))
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                widget.snap['postUrl'],
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await FireStoreFunctions().upPost(widget.snap['postID'],
                          widget.uid, widget.snap['up'], widget.snap['down']);
                    },
                    icon: widget.snap['up'].contains(uid)
                        ? Icon(Icons.arrow_upward,
                            size: 31, color: Colors.blue.withAlpha(150))
                        : Icon(Icons.arrow_upward, color: Colors.black)),
                IconButton(
                    onPressed: () async {
                      await FireStoreFunctions().downPost(widget.snap['postID'],
                          widget.uid, widget.snap['up'], widget.snap['down']);
                    },
                    icon: widget.snap['down'].contains(uid)
                        ? Icon(Icons.arrow_downward,
                            size: 31, color: Colors.redAccent.withAlpha(150))
                        : Icon(Icons.arrow_downward, color: Colors.black)),
                IconButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => Comments(
                                  snap: widget.snap,
                                )))),
                    icon:
                        Icon(Icons.mode_comment_outlined, color: Colors.black)),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ))
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['up'].length - widget.snap['down'].length}  up',
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: widget.snap['description'],
                            )
                          ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '5 comments',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['pushlishedDate'].toDate()),
                      style: GoogleFonts.quicksand(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
