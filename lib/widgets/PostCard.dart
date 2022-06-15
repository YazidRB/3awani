import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/comments/Comments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  int commentsLen = 0;
  Map? category;

  @override
  void initState() {
    super.initState();

    getComments();
    setState(() {
      category = widget.snap["category"];
    });
  }

  void deletreportingPost() async {
    try {
      await FireStoreFunctions()
          .reportPost(widget.snap["postID"], uid!, widget.snap["reports"]);

      if (widget.snap["reports"].length >= 3) {
        await FireStoreFunctions().deletePost(widget.snap['postID']);
      }
    } catch (e) {}
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postID'])
          .collection('comments')
          .get();
      setState(() {
        commentsLen = snap.docs.length;
      });
    } catch (e) {}
  }

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
                widget.snap['profImage'] == null
                    ? CircleAvatar(
                        radius: 16,
                        backgroundImage:
                            AssetImage('assets/images/default-avatar.png'),
                      )
                    : CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(widget.snap['profImage']),
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
                                  children: widget.snap['uid'] == uid
                                      ? ['Delete']
                                          .map(
                                            (e) => InkWell(
                                              highlightColor: Colors.red,
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                await FireStoreFunctions()
                                                    .deletePost(
                                                        widget.snap['postID']);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                            ),
                                          )
                                          .toList()
                                      : ['Report']
                                          .map(
                                            (e) => InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();

                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        Dialog(
                                                            child: ListView(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        16),
                                                                shrinkWrap:
                                                                    true,
                                                                children: [
                                                                  'Off topic content',
                                                                  'Duplicate content',
                                                                  'Others'
                                                                ]
                                                                    .map(
                                                                      (e) =>
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          deletreportingPost();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 12,
                                                                              horizontal: 16),
                                                                          child:
                                                                              Text(e),
                                                                        ),
                                                                      ),
                                                                    )
                                                                    .toList())));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
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
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        category!['food'] == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.fastfood,
                                  color: Colors.grey,
                                  size: 18.5,
                                ),
                              )
                            : Container(),
                        category!['money'] == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.money,
                                  color: Colors.grey,
                                  size: 18.5,
                                ),
                              )
                            : Container(),
                        category!['clothes'] == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.checkroom,
                                  color: Colors.grey,
                                  size: 18.5,
                                ),
                              )
                            : Container(),
                        category!['physical'] == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.accessibility,
                                  color: Colors.grey,
                                  size: 18.5,
                                ),
                              )
                            : Container(),
                        category!['drugs'] == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.vaccines,
                                  color: Colors.grey,
                                  size: 18.5,
                                ),
                              )
                            : Container(),
                        category!['others'] == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.interests,
                                  color: Colors.grey,
                                  size: 18.5,
                                ),
                              )
                            : Container(),
                      ],
                    ),
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
                        '${commentsLen} comments',
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
