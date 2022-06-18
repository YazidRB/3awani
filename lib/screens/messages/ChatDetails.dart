import 'package:aawani/resource/Colors.dart';
import 'package:aawani/resource/Globals.dart';
import 'package:aawani/screens/SignUp/Person/UserName.dart';
import 'package:aawani/screens/messages/Messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:intl/intl.dart';

class ChatDetails extends StatefulWidget {
  final receiver;
  final receiverPic;
  final receiverName;

  ChatDetails(
      {Key? key,
      required this.receiver,
      required this.receiverPic,
      required this.receiverName})
      : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.receiverName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.receiverPic),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .doc(uid!)
            .collection("disscution")
            .doc(widget.receiver)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Colors.black, backgroundColor: Colors.white),
            );
          }
          if (snapshot.data!.data() == null) return Container();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: snapshot.data!.data()!["details"].length,
                itemBuilder: (context, index) => Row(
                      children: [
                        snapshot.data!.data()!["details"][index]["receiver"] ==
                                uid
                            ? Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                            0.55 -
                                        24),
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: snapshot.data!.data()!["details"]
                                                [index]["receiver"] ==
                                            uid
                                        ? Colors.green
                                        : Colors.grey,
                                    child: Text(
                                      "${snapshot.data!.data()!["details"][index]["message"]}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                            0.55 -
                                        24),
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: snapshot.data!.data()!["details"]
                                                [index]["receiver"] ==
                                            uid
                                        ? Colors.green
                                        : Color.fromARGB(162, 158, 158, 158),
                                    child: Text(
                                      "${snapshot.data!.data()!["details"][index]["message"]}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: "Send a Message"),
              ),
            ),
            IconButton(
                onPressed: () async {
                  if (textEditingController.text != "" ||
                      textEditingController.text.isNotEmpty) {
                    try {
                      await FirebaseFirestore.instance
                          .collection("chat")
                          .doc(uid!)
                          .collection("disscution")
                          .doc(widget.receiver)
                          .set({
                        "receiverProfImage": widget.receiverPic,
                        "receiverId": widget.receiver,
                        "receiverUserName": widget.receiverName,
                        "details": FieldValue.arrayUnion([
                          {
                            "receiver": widget.receiver,
                            "sending": uid,
                            "message": textEditingController.text,
                            "date": DateTime.now(),
                          }
                        ])
                      }, SetOptions(merge: true));

                      await FirebaseFirestore.instance
                          .collection("chat")
                          .doc(widget.receiver!)
                          .collection("disscution")
                          .doc(uid)
                          .set({
                        "receiverProfImage": profImage,
                        "receiverId": uid,
                        "receiverUserName": userName,
                        "details": FieldValue.arrayUnion([
                          {
                            "receiver": widget.receiver,
                            "sending": uid,
                            "message": textEditingController.text,
                            "date": DateTime.now(),
                          }
                        ])
                      }, SetOptions(merge: true));
                      textEditingController.text = "";
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                },
                icon: Icon(Icons.send))
          ],
        ),
      ),
    );
  }

  // Future<MessagesC> getMessageData(
  //     String uidSending, String uidreceiver) async {
  //   String text;
  //   DateTime date;
  //   bool isSendByMe;

  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("chat")
  //       .doc(uidSending)
  //       .collection("disscution")
  //       .doc(uidreceiver)
  //       .get();

  //   date = snap["date"];
  //   text = snap["text"];
  //   return Messages(
  //       text, date, snap["receiver"] == uidSending ? true : false);
  // }
}
