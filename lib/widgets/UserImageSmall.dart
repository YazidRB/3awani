import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  final String ImageUrl;
  const UserImageSmall({
    Key? key,
    required this.ImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, right: 8),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(ImageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
