import 'package:flutter/material.dart';
import 'package:alumni/screens/auxScreens/Update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class UserList extends StatefulWidget {
  const UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final Stream<QuerySnapshot> usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  // For Deleting User
  CollectionReference users =
  FirebaseFirestore.instance.collection('users');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return users
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(80),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Text(
                              'Number',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blueAccent,
                          child: Center(
                            child: Text(
                              'Actions',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['name'],
                                  style: TextStyle(fontSize: 12.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['SubAdmin'],
                                  style: TextStyle(fontSize: 12.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['Number'],
                                  style: TextStyle(fontSize: 12.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Update(
                                              id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        }
    );
  }
}

