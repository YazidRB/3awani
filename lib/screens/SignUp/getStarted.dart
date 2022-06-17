import 'package:aawani/resource/Colors.dart';
import 'package:aawani/widgets/SignUpAppBar.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: SignUpAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Icon(
                    Icons.handshake,
                    size: 100,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Welcome To aawani ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                          color: Color.fromARGB(255, 22, 22, 22),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7,
                          fontSize: 22),
                    )),
                    Container(
                      child: Text(
                          'Help poeple with anything or Find poeple who can helps you with anything !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.32,
              padding: EdgeInsets.symmetric(vertical: 43),
              child: GredientButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('UserType');
                },
                splashColor: Color.fromARGB(255, 194, 193, 193),
                colors: [
                  primaryColor,
                  primaryColor,
                ],
                title: "Start",
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () => {Navigator.of(context).pushNamed('Login')},
                child: Text(
                  "already have an account? Login",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignUpAppBar extends StatelessWidget {
  const SignUpAppBar({
    Key? key,
  }) : super(key: key);

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
                'lib/icons/tinder-2.svg',
                height: 35,
                color: primaryColor,
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
        ),
      ),
    );
  }
}
