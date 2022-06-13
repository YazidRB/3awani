import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String email;
  final String uid;
  final String userName;
  final String profImage = '';
  final String helpType;
  final Map<String, bool> categories;
  final String phone;
  final String place;
  final String realName;
  final String userType;

  User({
    required this.email,
    required this.categories,
    required this.uid,
    required this.userName,
    required this.phone,
    required this.place,
    required this.helpType,
    required this.realName,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'userName': userName,
        'email': email,
        'profImage': profImage,
        'phone': phone,
        'place': place,
        'helpType': helpType,
        'realName': realName,
        'userType': userType,
        'categories': categories,
      };
  fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userName: snapshot['userName'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      categories: snapshot['categories'],
      realName: snapshot['realName'],
      userType: snapshot['userType'],
      helpType: snapshot['helpType'],
      place: snapshot['place'],
      phone: snapshot['phone'],
    );
  }
}
