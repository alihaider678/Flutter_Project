import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniproject/Modal/Authenication.dart';

import '../Theme/CustomStyle.dart';
import '../Widgets/CustomFlatButton.dart';
import '../Widgets/CustomTextButton.dart';
import '../Widgets/Loader.dart';
import 'Home.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController? emailCtrl, passwordCtrl;

  final _formKey = GlobalKey<FormState>();
  bool loader = false;

  Authentication _authentication = Authentication();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: <Widget>[loginForm(context), LoadingWidget(loader)],
    ));
  }

  Widget LoadingWidget(bool flag) {
    if (flag) {
      return Loader();
    } else {
      return Container();
    }
  }

  Widget loginForm(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.white.withOpacity(0.5), Colors.blue],
              ),
            ),
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextFieldDecoration(
                          hintText: "Email", labelText: "Email"),
                      controller: emailCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: TextFieldDecoration(
                          hintText: "Password", labelText: "Password"),
                      controller: passwordCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustonFlatButton(
                    title: "Login",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            loader = true;
                          });
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailCtrl!.text,
                                  password: passwordCtrl!.text);
                          _authentication.ShowToast(
                              context, "Login successful");
                          setState(() {
                            loader = false;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        } on FirebaseAuthException catch (e) {
                          _authentication.ShowToast(context, e.toString());
                          setState(() {
                            loader = false;
                          });
                        }
                      }
                    },
                  ),
                  CustomTextButton(
                    title: "Create new account",
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                  )
                ],
              ),
            ));
      },
    );
  }
}
