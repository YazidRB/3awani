import 'dart:io';
import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
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
  File? _file;
  TextEditingController textEditingController = TextEditingController();
  bool _isLoading = false;

  postImage(String uid, String username, String profImage,
      Map<String, bool> category) async {
    try {
      String res = await FireStoreFunctions().uploadPost(
          textEditingController.text,
          _file!,
          uid,
          username,
          profImage,
          category);

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Posted !')));
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
                    _file = File(xfile!.path);
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
                    _file = File(xfile!.path);
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

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
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
                  onPressed: clearImage,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
              title: title,
              actions: [
                TextButton(
                    onPressed: () async {
                      await postImage(globals.uid!, globals.userName!,
                          globals.profImage!, globals.categories);
                    },
                    child: Text('Post',
                        style: GoogleFonts.quicksand(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 27)))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 13.5, horizontal: 0),
              child: Column(
                children: [
                  _isLoading
                      ? const LinearProgressIndicator(
                          minHeight: 10,
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
                                  'https://www.pngkey.com/png/detail/115-1150152_default-profile-picture-avatar-png-green.png')
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
                                image: FileImage(_file!),
                              ))),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 12,
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "What the category of what you need ?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(child: Container()),
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
                                return Icon(
                                  Icons.fastfood_outlined,
                                  color: isLiked ? primaryColor : Colors.grey,
                                  size: 27,
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
                                return Icon(
                                  Icons.money,
                                  color: isLiked ? primaryColor : Colors.grey,
                                  size: 27,
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
                              return Icon(
                                Icons.checkroom,
                                color: isLiked ? primaryColor : Colors.grey,
                                size: 27,
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
                              return Icon(
                                Icons.accessibility,
                                color: isLiked ? primaryColor : Colors.grey,
                                size: 27,
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
                              return Icon(
                                Icons.vaccines,
                                color: isLiked ? primaryColor : Colors.grey,
                                size: 27,
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
                              return Icon(
                                Icons.interests,
                                color: isLiked ? primaryColor : Colors.grey,
                                size: 27,
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
