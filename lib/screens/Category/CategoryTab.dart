import 'package:aawani/screens/addPost/FeedPost.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CategoryTab extends StatefulWidget {
  String iconCategory;
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
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(5),
              child: InkWell(
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
                      Image.asset(
                        widget.iconCategory,
                        width: 50,
                        color: widget.cat == "money "
                            ? Colors.green
                            : widget.cat == "food"
                                ? Colors.orange
                                : widget.cat == "clothes"
                                    ? Colors.blue
                                    : widget.cat == "physical"
                                        ? Colors.grey
                                        : widget.cat == "drugs"
                                            ? Colors.red
                                            : null,
                      ),
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
