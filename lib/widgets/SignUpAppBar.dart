import 'package:aawani/resource/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
            margin: const EdgeInsets.only(top: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'lib\\assets\\tinder-2.svg',
                    height: 35,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  child: Text(
                    'Aawani',
                    style: GoogleFonts.quicksand(
                        color: primaryColor, fontWeight: FontWeight.w800),
                  ),
                )
              ],
            )));
  }
}
