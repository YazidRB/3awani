import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/models/Post.dart';
import 'package:aawani/screens/profile/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FireStoreFunctions {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, File file, bool isPost) async {
    Reference storageRef = storage.ref().child(childName).child(globals.uid!);

    if (isPost) {
      String id = const Uuid().v1();
      storageRef = storageRef.child(id);
    }

    UploadTask uploadTask = storageRef.putFile(file);

    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }

  Future<String> uploadPost(String description, File file, String uid,
      String userName, String profImage, Map<String, bool> category) async {
    String res = 'Some erreur !';
    try {
      String photoUrl = await uploadImageToStorage('posts', file, true);

      String postID = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          userName: userName,
          category: category,
          postID: postID,
          pushlishedDate: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          down: [],
          up: [],
          reports: []);

      firestore.collection('posts').doc(postID).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> upPost(String postId, String uid, List up, List down) async {
    try {
      if (up.contains(uid)) {
        await firestore.collection('posts').doc(postId).update({
          'up': FieldValue.arrayRemove([uid])
        });
      } else {
        if (down.contains(uid)) {
          await firestore.collection('posts').doc(postId).update({
            'down': FieldValue.arrayRemove([uid])
          });
        }
        await firestore.collection('posts').doc(postId).update({
          'up': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> downPost(String postId, String uid, List up, List down) async {
    try {
      if (down.contains(uid)) {
        await firestore.collection('posts').doc(postId).update({
          'down': FieldValue.arrayRemove([uid])
        });
      } else {
        if (up.contains(uid)) {
          await firestore.collection('posts').doc(postId).update({
            'up': FieldValue.arrayRemove([uid])
          });
        }
        await firestore.collection('posts').doc(postId).update({
          'down': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> reportPost(String postId, String uid, List reports) async {
    try {
      if (!reports.contains(uid)) {
        await firestore.collection('posts').doc(postId).update({
          'reports': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'userName': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print("Empty Text");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //delete post
  Future<void> deletePost(String postId) async {
    try {
      await firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
