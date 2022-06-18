import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/Phone/SMSCodeDialog.dart';
import 'package:aawani/screens/SignUp/both/HelpCategories.dart';
import 'package:aawani/screens/home/MyHomePage.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Phone extends StatefulWidget {
  Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

TextEditingController tc = TextEditingController();
final TextEditingController phoneController = new TextEditingController();

final _formKey = GlobalKey<FormState>();
Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;

String _countryCode = "+213";
@override
void dispose() {
  phoneController.dispose();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Vérification code ",
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
                fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/icons/icons8-message-64.png"),
                  Text(
                    "send code to \n ${globals.phone!.substring(0, 4)}****** ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        fontSize: 21,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                  onPressed: () => onPressed(context),
                  child: Text("Send")),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  void onPressed(BuildContext context) {
    String phone = globals.phone!;

    Auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+213' + globals.phone!,
      timeout: Duration(seconds: 120),
      verificationCompleted: (Auth.PhoneAuthCredential credential) {
        print("it's valid");
      },
      verificationFailed: (Auth.FirebaseAuthException e) {
        print("failed");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      },
      codeSent: (String verificationId, int? resendToken) async {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return SMSCodeDialog(
                  phoneNumber: _countryCode + phone,
                  resendToken: resendToken,
                  onSMSCodeEntered: (smsCode, dialogContext) async {
                    try {
                      Auth.PhoneAuthCredential credential =
                          Auth.PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: smsCode);

                      Navigator.of(dialogContext).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Wrong sms "
                              "code")));
                    }
                  });
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("timeout");
      },
    );
  }
}
