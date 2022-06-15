import 'package:aawani/screens/Search/SearchProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.white,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
              icon: Icon(Icons.search), label: Text("Search for a user")),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .where("userName", isEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchProfile(
                                  snap:
                                      (snapshot.data! as dynamic).docs[index])),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]
                                ["profImage"]),
                      ),
                      title: Text(
                          (snapshot.data! as dynamic).docs[index]["userName"]),
                      trailing: (snapshot.data! as dynamic).docs[index]
                                  ["helpType"] ==
                              "needHelp"
                          ? Icon(
                              Icons.back_hand,
                              size: 20,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.volunteer_activism_sharp,
                              size: 20,
                              color: Colors.green,
                            ),
                    );
                  },
                );
              },
            )
          : Center(child: Text("Search result will apear here  ")),
    );
  }
}
