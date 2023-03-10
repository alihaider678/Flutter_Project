import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'Login.dart';

class Root extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RootState();
  }
}

class RootState extends State<Root> {
  bool checkUser = true;
  Widget rootWidget = Container();
  User? user;

  @override
  void initState() {
    checkUser = true;
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  isLoggedIn() async {
    var _user = await FirebaseAuth.instance.currentUser;
    print("USER $_user");
    if (_user != null) {
      print("HAS USER");
      setState(() {
        user = _user;
        checkUser = false;
        rootWidget = Home();
      });
    } else {
      setState(() {
        checkUser = false;
        rootWidget = Login();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return checkUser ? Loder() : rootWidget;
  }

  Widget Loder() {
    return Scaffold(
      body: Container(
        color: Colors.black26,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
