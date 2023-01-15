import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/Home.dart';
import 'pages/Login.dart';
import 'pages/Root.dart';

User? user = FirebaseAuth.instance.currentUser;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/root': (context) => Root()
      },
    );
  }
}
