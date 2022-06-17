import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart' as globals;
import 'package:aawani/screens/Phone/SMSCodeDialog.dart';
import 'package:aawani/screens/SignUp/both/HelpCategories.dart';
import 'package:aawani/screens/home/MyHomePage.dart';
import 'package:aawani/widgets/GredientButton.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
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
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 4,
                child: Text(
                  "confirm code number please \n ${globals.phone!.substring(0, 4)}*********",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: 21,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: "Phone Number"),
                        validator: (value) {
                          String pattern = r'(^(?:[+0]9)?[0-9]{8,12}$)';
                          RegExp regExp = new RegExp(pattern);

                          if (value!.isEmpty) {
                            return "Please enter your phone number";
                          }
                          if (!regExp.hasMatch(value)) {
                            return "Please enter a valid phone number";
                          }

                          return null;
                        },
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ),
              Spacer(flex: 2),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => onPressed(context),
                      child: Text("Confirm"))),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed(BuildContext context) {
    String phone = phoneController.text;
    // String name = nameController.text;

    if (_formKey.currentState!.validate()) {
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
                                verificationId: verificationId,
                                smsCode: smsCode);

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
}
