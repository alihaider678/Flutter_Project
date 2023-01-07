import 'package:alumni/screens/auxScreens/UsersList.dart';
import 'package:flutter/material.dart';
import 'package:alumni/screens/auxScreens/Update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ViewPage());
}

class ViewPage extends StatefulWidget {


  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // CHeck for Errors
        if (snapshot.hasError) {
          print("Something went Wrong");
        }
        // once Completed, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(appBar: AppBar(
            title: Text('View Users'),
          ),
            body: UserList(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
