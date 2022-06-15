import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/messages/ChatDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List chatPics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'ChatPage',
            style: GoogleFonts.quicksand(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chat")
                .doc(uid!)
                .collection("disscution")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Center(
                    child: CircularProgressIndicator(
                        color: Colors.black, backgroundColor: Colors.white),
                  ),
                );
              }
              if (snapshot.data == null)
                return Container(
                  child: Center(
                      child: Text(
                    "No Messages yet ! ",
                    style: TextStyle(color: Colors.black),
                  )),
                );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetails(
                                receiver: snapshot.data!.docs[index]
                                    .data()["receiverId"],
                                receiverPic: snapshot.data!.docs[index]
                                    .data()["receiverProfImage"],
                                receiverName: snapshot.data!.docs[index]
                                    .data()["receiverUserName"],
                              ),
                            ));
                      },
                      leading: snapshot.data!.docs[index]
                                      .data()["receiverProfImage"] ==
                                  null ||
                              snapshot.data!.docs[index]
                                      .data()["receiverProfImage"] ==
                                  "assets/images/default-avatar.png"
                          ? CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/default-avatar.png"))
                          : CircleAvatar(
                              backgroundImage: NetworkImage(snapshot
                                  .data!.docs[index]
                                  .data()["receiverProfImage"]),
                            ),
                      title: Text(
                        snapshot.data!.docs[index].data()["receiverUserName"],
                        style: GoogleFonts.quicksand(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
