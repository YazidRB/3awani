import 'dart:typed_data';
import 'package:aawani/resource/Globals.dart' as globals;

import 'package:aawani/models/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class FireStoreFunctions {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    final storageRef = storage.ref().child(childName).child(globals.uid!);

    if (isPost) {
      String id = const Uuid().v1();
      storageRef.child(id);
    }

    UploadTask uploadTask = storageRef.putData(file);

    TaskSnapshot snap = await uploadTask;
    print('Done !');
    print('Done !');
    print('Done !');
    return await snap.ref.getDownloadURL();
  }

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String userName, String profImage) async {
    String res = 'Some erreur !';
    try {
      String photoUrl = await uploadImageToStorage('posts', file, true);
      print(
          'Donnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnngggggggggggg');

      String postID = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          userName: userName,
          postID: postID,
          pushlishedDate: DateTime.now(),
          postUrl: photoUrl,
          profImage: 'pro',
          likes: []);

      firestore.collection('posts').doc(postID).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
