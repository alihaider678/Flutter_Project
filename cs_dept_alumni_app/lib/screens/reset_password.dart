import 'package:alumni/resources/firebaseRepos.dart';
import 'package:alumni/screens/loginRelatedScreens/secondScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:email_validator/email_validator.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _email = new TextEditingController();
  FirebaseRepos _repository = new FirebaseRepos();

  String email = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Container(
            height: height,
            width: width,
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  height: height * .3,
                  alignment: Alignment.bottomCenter,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.lightBlue,
                    child: Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * .1,
                // ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            validator: (value) {
                              if (!EmailValidator.validate(_email.text)) {
                                return 'Please enter a vaild email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          // TextFormField(
                          //   decoration: InputDecoration(
                          //     hintText: "Password",
                          //     hintStyle:
                          //     TextStyle(color: Colors.black, fontSize: 16),
                          //     filled: true,
                          //     fillColor: Colors.white,
                          //     contentPadding: EdgeInsets.all(10),
                          //     border: new OutlineInputBorder(
                          //       borderRadius: new BorderRadius.circular(10.0),
                          //       borderSide: new BorderSide(),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.blue),
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //   ),
                          //   obscureText: true,
                          //   controller: _password,
                          //   keyboardType: TextInputType.emailAddress,
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 16,
                          //   ),
                          //   validator: (value) {
                          //     if (_password.text.length < 6) {
                          //       return 'Password length must be greater than 6 characters';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            color: Colors.lightBlue,
                            child: Text(
                              "Reset",
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                                  FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text).then((value) => Navigator.of(context).pop());
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.white)),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
