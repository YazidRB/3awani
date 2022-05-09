import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  final String description;
  final String uid;
  final String userName;
  final String postID;
  final pushlishedDate;
  final String postUrl;
  final String profImage;
  final likes;

  Post(
      {required this.pushlishedDate,
      required this.description,
      required this.uid,
      required this.userName,
      required this.postID,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'userName': userName,
        'postID': postID,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes,
        'pushlishedDate': pushlishedDate
      };
  fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        pushlishedDate: snapshot['pushlishedDate'],
        userName: snapshot['userName'],
        description: snapshot['description'],
        uid: snapshot['uid'],
        postID: snapshot['postID'],
        postUrl: snapshot['postUrl'],
        likes: snapshot['likes'],
        profImage: snapshot['profImage']);
  }
}
