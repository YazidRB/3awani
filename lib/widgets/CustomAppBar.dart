import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resource/Colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              'lib\\assets\\tinder-2.svg',
              height: 35,
              color: primaryColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'DISCOVER',
              style: GoogleFonts.quicksand(
                  fontSize: 30,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('Profile');
            },
            icon: Icon(
              Icons.person_outline,
              size: 33,
              color: Colors.grey,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              size: 29,
              color: Colors.grey,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
