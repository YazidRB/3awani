import 'dart:typed_data';
import 'package:aawani/functions/FireStoreFunctions.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/functions/Functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

final title =
    Text('Add Post', style: GoogleFonts.quicksand(color: Colors.grey));

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  TextEditingController textEditingController = TextEditingController();

  postImage(String uid, String username, String profImage) async {
    try {
      String res = await FireStoreFunctions().uploadPost(
          textEditingController.text, _file!, uid, username, 'profImage');
      print('Donnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');

      if (res == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Posted !')));
        print('Donnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn2');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
        print('Donnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn3');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print('Donnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn4');
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
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Chose a Picture'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
              title: title,
              actions: [
                TextButton(
                    onPressed: () async {
                      await postImage(globals.uid!, globals.userName!,
                          ' globals.profImage!');
                    },
                    child: Text('Post',
                        style: GoogleFonts.quicksand(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://uwosh.edu/deanofstudents/wp-content/uploads/sites/156/2019/02/profile-default.jpg'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
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
                          width: 45,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(_file!),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center))),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 12,
                        ),
                      ])
                ],
              ),
            ),
          );
  }
}
