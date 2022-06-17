import 'package:aawani/screens/Login/Login.dart';
import 'package:aawani/screens/Phone/Phone.dart';
import 'package:aawani/screens/Search/Search.dart';
import 'package:aawani/screens/SignUp/Person/UserEmail.dart';
import 'package:aawani/screens/SignUp/both/HelpCategories.dart';
import 'package:aawani/screens/SignUp/both/HelpProfileSignUp.dart';
import 'package:aawani/screens/SignUp/Person/UserName.dart';
import 'package:aawani/screens/SignUp/both/Helpedaddpost.dart';
import 'package:aawani/screens/SignUp/both/Pass.dart';
import 'package:aawani/screens/SignUp/both/UserHelpType.dart';
import 'package:aawani/screens/SignUp/both/UserType.dart';
import 'package:aawani/screens/SignUp/getStarted.dart';
import 'package:aawani/screens/addPost/Place.dart';
import 'package:aawani/screens/home/MyHomePage.dart';
import 'package:aawani/screens/messages/ChatPage.dart';
import 'package:aawani/screens/profile/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'aawani',
      options: FirebaseOptions(
          apiKey: "AIzaSyAW4dhaajLyKaBFkt3QVZxInUwMdHyS6XM",
          authDomain: "awani-5e5f5.firebaseapp.com",
          projectId: "awani-5e5f5",
          storageBucket: "awani-5e5f5.appspot.com",
          messagingSenderId: "210054971535",
          appId: "1:210054971535:web:7ad2df288ab0a586b230fa"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Login(),
      routes: {
        'GetStarted': (context) => GetStarted(),
        'UserType': (context) => UserType(),
        'UserName': (context) => UserName(),
        'UserEmail': (context) => UserEmail(),
        'Pass': (context) => Pass(),
        'UserHelpType': (context) => UserHelpType(),
        'HelpProfileSignUp': (context) => HelpProfileSignUp(),
        "HelpCategories": (context) => HelpCategories(),
        'Login': (context) => Login(),
        'homePage': (context) => MyHomePage(),
        "HelpAddpost": (context) => HelpAddpost(),
        "Profile": (context) => ProfilePage(),
        "phone": (context) => Phone(),
      },
    );
  }
}
