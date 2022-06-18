import 'dart:io';
import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/addPost/Place.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

final title =
    Text('Add Post', style: GoogleFonts.quicksand(color: Colors.grey));

class _AddPostState extends State<AddPost> {
  Map<String, bool> categories = {
    'food': false,
    'money ': false,
    'clothes': false,
    'physical': false,
    'drugs': false,
    'others': false
  };
  TextEditingController textEditingController = TextEditingController();
  bool _isLoading = false;

  clearCat() {
    setState(() {
      categories = {
        'food': false,
        'money ': false,
        'clothes': false,
        'physical': false,
        'drugs': false,
        'others': false
      };
    });
  }

  clearImage() {
    setState(() {
      globals.file = null;
    });
  }

  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Creat a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(27),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final xfile =
                      await ImagePicker().pickImage(source: ImageSource.camera);

                  setState(() {
                    globals.file = File(xfile!.path);
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(27),
                child: const Text('Chose a Picture'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final xfile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  setState(() {
                    globals.file = File(xfile!.path);
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(27),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return globals.file == null
        ? Center(
            child: IconButton(
              onPressed: () => selectImage(context),
              icon: Icon(
                Icons.image,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    clearImage();
                    clearCat();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
              title: title,
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Place(
                                  category: categories,
                                  text: textEditingController.text,
                                )),
                      );
                    },
                    child: Text('Add location',
                        style: GoogleFonts.quicksand(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 13.5, horizontal: 0),
              child: Column(
                children: [
                  _isLoading
                      ? const LinearProgressIndicator(
                          minHeight: 10,
                          color: Colors.blue,
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: globals.profImage == null
                              ? NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/2017/2017701.png')
                              : NetworkImage(globals.profImage!),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: 'Writ post ',
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          width: 65,
                          child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                  child: Image(
                                image: FileImage(globals.file!),
                              ))),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 12,
                        ),
                      ]),
                  // START

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            LikeButton(
                              isLiked: categories['food'],
                              onTap: (isLiked) async {
                                setState(() {
                                  if (!isLiked)
                                    categories['food'] = true;
                                  else
                                    categories['food'] = false;
                                });
                              },
                              size: 27,
                              circleSize: 50,
                              circleColor: CircleColor(
                                  start: Colors.grey, end: primaryColor),
                              animationDuration: Duration(milliseconds: 300),
                              bubblesColor: BubblesColor(
                                  dotPrimaryColor: primaryColor,
                                  dotSecondaryColor: Colors.grey),
                              likeBuilder: (bool isLiked) {
                                return Image.asset(
                                  'lib/icons/icons8-hamburger-96(-xxxhdpi).png',
                                  color: isLiked ? Colors.orange : Colors.grey,
                                );
                              },
                            ),
                            Text(
                              'Food',
                              style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            LikeButton(
                              isLiked: categories['money'],
                              onTap: (isLiked) async {
                                setState(() {
                                  if (!isLiked)
                                    categories['money'] = true;
                                  else
                                    categories['money'] = false;
                                });
                              },
                              size: 27,
                              circleSize: 50,
                              circleColor: CircleColor(
                                  start: Colors.grey, end: primaryColor),
                              animationDuration: Duration(milliseconds: 300),
                              bubblesColor: BubblesColor(
                                  dotPrimaryColor: primaryColor,
                                  dotSecondaryColor: Colors.grey),
                              likeBuilder: (bool isLiked) {
                                return Image.asset(
                                  'lib/icons/icons8-money-96(-xxxhdpi).png',
                                  color: isLiked ? Colors.green : Colors.grey,
                                );
                              },
                            ),
                            Text(
                              'Money',
                              style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          LikeButton(
                            isLiked: categories['clothes'],
                            onTap: (isLiked) async {
                              setState(() {
                                if (!isLiked)
                                  categories['clothes'] = true;
                                else
                                  categories['clothes'] = false;
                              });
                            },
                            size: 27,
                            circleSize: 50,
                            circleColor: CircleColor(
                                start: Colors.grey, end: primaryColor),
                            animationDuration: Duration(milliseconds: 300),
                            bubblesColor: BubblesColor(
                                dotPrimaryColor: primaryColor,
                                dotSecondaryColor: Colors.grey),
                            likeBuilder: (bool isLiked) {
                              return Image.asset(
                                'lib/icons/icons8-clothes-64.png',
                                color: isLiked ? Colors.blue : Colors.grey,
                              );
                            },
                          ),
                          Text(
                            'Clothes',
                            style: GoogleFonts.quicksand(
                                color: Colors.grey,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          LikeButton(
                            isLiked: categories['physical'],
                            onTap: (isLiked) async {
                              setState(() {
                                if (!isLiked)
                                  categories['physical'] = true;
                                else
                                  categories['physical'] = false;
                              });
                            },
                            size: 27,
                            circleSize: 50,
                            circleColor: CircleColor(
                                start: Colors.grey, end: primaryColor),
                            animationDuration: Duration(milliseconds: 300),
                            bubblesColor: BubblesColor(
                                dotPrimaryColor: primaryColor,
                                dotSecondaryColor: Colors.grey),
                            likeBuilder: (bool isLiked) {
                              return Image.asset(
                                'lib/icons/icons8-teenager-male-100.png',
                                color: isLiked ? Colors.yellow : Colors.grey,
                              );
                            },
                          ),
                          Text(
                            'Physical',
                            style: GoogleFonts.quicksand(
                                color: Colors.grey,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          LikeButton(
                            isLiked: categories['drugs'],
                            onTap: (isLiked) async {
                              setState(() {
                                if (!isLiked)
                                  categories['drugs'] = true;
                                else
                                  categories['drugs'] = false;
                              });
                            },
                            size: 27,
                            circleSize: 50,
                            circleColor: CircleColor(
                                start: Colors.grey, end: primaryColor),
                            animationDuration: Duration(milliseconds: 300),
                            bubblesColor: BubblesColor(
                                dotPrimaryColor: primaryColor,
                                dotSecondaryColor: Colors.grey),
                            likeBuilder: (bool isLiked) {
                              return Image.asset(
                                'lib/icons/icons8-drugs-64.png',
                                color: isLiked ? Colors.red : Colors.grey,
                              );
                            },
                          ),
                          Text(
                            'Drugs',
                            style: GoogleFonts.quicksand(
                                color: Colors.grey,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          LikeButton(
                            isLiked: categories['others'],
                            onTap: (isLiked) async {
                              setState(() {
                                if (!isLiked)
                                  categories['others'] = true;
                                else
                                  categories['others'] = false;
                              });
                            },
                            size: 27,
                            circleSize: 50,
                            circleColor: CircleColor(
                                start: Colors.grey, end: primaryColor),
                            animationDuration: Duration(milliseconds: 300),
                            bubblesColor: BubblesColor(
                                dotPrimaryColor: primaryColor,
                                dotSecondaryColor: Colors.grey),
                            likeBuilder: (bool isLiked) {
                              return Image.asset(
                                'lib/icons/icons8-categorize-48.png',
                                color: isLiked ? null : Colors.grey,
                              );
                            },
                          ),
                          Text(
                            'Others',
                            style: GoogleFonts.quicksand(
                                color: Colors.grey,
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),

                  // END
                ],
              ),
            ),
          );
  }
}
