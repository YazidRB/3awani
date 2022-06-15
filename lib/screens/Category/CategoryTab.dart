import 'package:aawani/screens/addPost/FeedPost.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CategoryTab extends StatefulWidget {
  IconData iconCategory;
  final cat;
  CategoryTab({Key? key, required this.cat, required this.iconCategory})
      : super(key: key);
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: InkWell(
                focusColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeedPost(cat: widget.cat)),
                  );
                },
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.iconCategory),
                      Text(
                        " ${widget.cat}",
                        style: GoogleFonts.quicksand(
                            color: Colors.grey,
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
