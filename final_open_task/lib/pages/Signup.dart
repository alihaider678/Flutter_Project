import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Modal/Authenication.dart';
import '../Theme/CustomStyle.dart';
import '../Widgets/CustomFlatButton.dart';
import '../Widgets/CustomTextButton.dart';
import '../Widgets/Loader.dart';
import 'Home.dart';
import 'Login.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  FocusNode? email;
  FocusNode? password;

  TextEditingController? emailCtrl;
  TextEditingController? passwordCtrl;
  Authentication _authentication = Authentication();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  @override
  bool loader = false;
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Builder(builder: (context) {
      return Stack(
        children: <Widget>[
          signupForm(context),
          loader ? Loader() : Container()
        ],
      );
    }));
  }

  Widget signupForm(BuildContext context) {
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
                "Signup",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                  controller: emailCtrl,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: TextFieldDecoration(
                      hintText: "Email", labelText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Email";
                    }
                  }),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: TextFieldDecoration(
                      labelText: "Password", hintText: "Password"),
                  onFieldSubmitted: (value) {
                    password?.unfocus();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    }
                  }),
              SizedBox(
                height: 10.0,
              ),
              CustonFlatButton(
                title: "Signup",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      setState(() {
                        loader = true;
                      });
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailCtrl!.text,
                              password: passwordCtrl!.text);
                      _authentication.ShowToast(context, "SignUp successful");
                      setState(() {
                        loader = false;
                      });
                      _formKey.currentState?.reset();
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
                title: "Already have an account ? ",
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              )
            ],
          ),
        ));
  }
}
