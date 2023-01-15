import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnlineResult extends StatefulWidget {
  @override
  State<OnlineResult> createState() => _OnlineResultState();
}

class _OnlineResultState extends State<OnlineResult> {
  @override
  User? current = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> firebaselist = [];

  @override
  void initState() {
    super.initState();
    firebasedata();
    print(firebaselist);
  }

  void firebasedata() async {
    QuerySnapshot snapshot = await _firestore
        .collection("ali")
        .doc(current?.uid)
        .collection('data')
        .get();
    setState(() {
      firebaselist = snapshot.docs.map((e) => e["quiz"]).toList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Record"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("ali")
              .doc(current?.uid)
              .collection('data')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {}

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                List<dynamic> stringlist =
                    firebaselist.map((e) => e as dynamic).toList();

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quiz ${index + 1}",
                            style: TextStyle(color: Colors.black, fontSize: 24),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i < stringlist.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      stringlist[index][i].toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
