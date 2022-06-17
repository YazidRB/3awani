import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/home/MyHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aawani/models/User.dart' as models;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final fsp = GlobalKey<FormState>();
  final fsm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? password;
    String? email;

    getProfileData() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      globals.uid = FirebaseAuth.instance.currentUser!.uid;
      globals.email = FirebaseAuth.instance.currentUser!.email;
      globals.phone = data['phone'];
      globals.place = data['place'];
      globals.realName = data['realName'];
      globals.userType = data['userType'];
      globals.userName = data['userName'];
      globals.suc = data['suc'];
      globals.sexe = data['sexe'];
      globals.profImage = data["profImage"] != null
          ? data["profImage"]
          : "assets/images/default-avatar.png";

      globals.helpType = data['userType'];
    }

    bool isLoading = false;

    return Scaffold(
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : ListView(
              children: <Widget>[
                Expanded(child: Container()),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                  child: Text(
                    "Login ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        fontSize: 36,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: fsm,
                    child: TextFormField(
                      onSaved: ((newValue) {
                        email = newValue;
                      }),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'email'),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: fsp,
                    child: TextFormField(
                      onSaved: (newValue) {
                        password = newValue;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "forgot password?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        fsp.currentState!.save();
                        fsm.currentState!.save();

                        try {
                          setState(() {
                            isLoading = true;
                          });
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: email!, password: password!);

                          await getProfileData();

                          if (globals.suc == true) {
                            Navigator.of(context).pushReplacementNamed('phone');
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('No user found for that email.')));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Wrong password provided for that user')));
                          }
                        }
                      },
                      child: Container(
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed('GetStarted')
                    },
                    child: Text(
                      "Don't Have an Account? Sign up",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
