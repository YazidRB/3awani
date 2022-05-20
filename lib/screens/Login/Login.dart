import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aawani/models/User.dart' as models;

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final fsp = GlobalKey<FormState>();
    final fsm = GlobalKey<FormState>();
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
      globals.categories['food'] = data['categories']['food'];
      globals.categories['money'] = data['categories']['money'];
      globals.categories['clothes'] = data['categories']['clothes'];
      globals.categories['physical'] = data['categories']['physical'];
      globals.categories['drugs'] = data['categories']['drugs'];
      globals.categories['others'] = data['categories']['others'];

      globals.helpType = data['userType'];
    }

    bool isLoading = false;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: fsm,
                    child: TextFormField(
                      onSaved: ((newValue) {
                        email = newValue;
                      }),
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
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
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

                        Navigator.of(context).pushReplacementNamed('homePage');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(
                              colors: [primaryColor, primaryColor])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
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
