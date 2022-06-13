import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Post {
  final String description;
  final String uid;
  final String userName;
  final String postID;
  final pushlishedDate;
  final String postUrl;
  final String profImage;
  final up;
  final down;
  final reports;
  final category;

  Post(
      {required this.category,
      required this.pushlishedDate,
      required this.description,
      required this.uid,
      required this.userName,
      required this.postID,
      required this.postUrl,
      required this.profImage,
      required this.down,
      required this.reports,
      required this.up});

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'userName': userName,
        'postID': postID,
        'postUrl': postUrl,
        'profImage': profImage,
        'category': category,
        'up': up,
        'down': down,
        'pushlishedDate': pushlishedDate,
        'reports': reports
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
        category: snapshot['category'],
        up: snapshot['up'],
        down: snapshot['down'],
        reports: snapshot['reports'],
        profImage: snapshot['profImage']);
  }
}
