import 'package:alumni/modals.dart/universalVariables.dart';
import 'package:alumni/modals.dart/users.dart';
import 'package:alumni/resources/firebaseRepos.dart';
import 'package:alumni/screens/auxScreens/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String email;
  final String password;

  SecondScreen(this.email, this.password);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _rollNumber = TextEditingController();
  TextEditingController _course = TextEditingController();
  TextEditingController _startingYear = TextEditingController();
  TextEditingController _endingYear = TextEditingController();
  // TextEditingController _tag = TextEditingController();
  // TextEditingController _branch = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _skill = TextEditingController();
  FirebaseRepos _repository = FirebaseRepos();
  bool _shouldIRotate;
  String _tag = "Alumni";
  String _branch;
  String valueChange = "Select Blood Group...";
  List ListItem=["Select Blood Group...","A+","A-","B+","B-","AB+","AB-","O+","O-","NO"];
  int currentYear;
  int _value=1;
  @override
  void initState() {
    currentYear = DateTime.now().year;
    _shouldIRotate = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: UniversalVariables.blackColor,
        centerTitle: true,
        title: Text(
          "Enter info",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_name.text.length < 3)
                          return "Name must be atleast 3 characters long";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _course,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_course.text.length < 3)
                          return "Course name must be atleast 3 characters long";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Course",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    // TextFormField(
                    //   controller: _branch,
                    //   keyboardType: TextInputType.emailAddress,
                    //   style: TextStyle(fontSize: 16, color: Colors.black),
                    //   validator: (value) {
                    //     if (_branch.text.length < 2)
                    //       return "Blood Group must be atleast 2 characters long";
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: "Blood Group",
                    //     hintStyle:
                    //         TextStyle(fontSize: 16, color: Colors.grey[900]),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     contentPadding: EdgeInsets.all(10),
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(color: Colors.lightBlue)),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(

                        padding: EdgeInsets.only(left: 10,right: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1,),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,

                        ),

                        child: DropdownButton(

                              borderRadius: BorderRadius.circular(10),

                          dropdownColor: Colors.white,

                          hint: Text("Select Blood Group"),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          underline: SizedBox(),
                          value: valueChange,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          items: ListItem.map((valueItem)
                          {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),

                          onChanged: (newValue)
                          {
                            setState(() {
                              valueChange = newValue;
                              _branch = newValue;
                            });
                          },


                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _rollNumber,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_rollNumber.text.length < 8)
                          return "Roll number must be atleast 8 characters long";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Roll number(e.g:FA19-BCS-000)",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _number,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_number.text.length < 11)
                          return "Enter a Valid Number";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Contact #",
                        hintStyle:
                        TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    // TextFormField(
                    //   controller: _tag,
                    //   keyboardType: TextInputType.text,
                    //   style: TextStyle(fontSize: 16, color: Colors.black),
                    //   validator: (value) {
                    //     if (_tag.text.toUpperCase() != "STUDENT" &&
                    //         _tag.text.toUpperCase() != "ALUMNI")
                    //       return "Must be either student or alumni";
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: "Student or Alumni",
                    //     hintStyle:
                    //         TextStyle(fontSize: 16, color: Colors.grey[900]),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     contentPadding: EdgeInsets.all(10),
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(color: Colors.lightBlue)),
                    //   ),
                    // ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(value: 1, groupValue: _value, onChanged: (value){
setState(() {
  _value=value;
  _tag = "Alumni";
});
                            },
                            activeColor: Colors.red,),
                          SizedBox( width: 5.0,),
                            Text("Alumni",style: TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: 2, groupValue: _value, onChanged: (value){
                              setState(() {
                                _value=value;
                                _tag = "Student";
                              });
                            }),
                            SizedBox( width: 5.0,),
                            Text("Student",style: TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _skill,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_skill.text.length < 2)
                          return "Write Valid Skill ";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Major Skills",
                        hintStyle:
                        TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _startingYear,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_startingYear.text.length < 4 ||
                            int.parse(_startingYear.text) > currentYear)
                          return "Enter a Valid year";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Starting year",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _endingYear,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      validator: (value) {
                        if (_endingYear.text.length < 3)
                          return "Enter a valid year";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "End year",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey[900]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      color: Colors.lightBlue,
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _shouldIRotate = true;
                          });

                          _repository
                              .signUpWithEmail(widget.email, widget.password)
                              .then(

                            (userCredential) {
                              print('object');
                              User currentUser = userCredential.user;

                              MyUser myUser = MyUser(
                                name: _name.text,
                                course: _course.text,
                                email: widget.email,
                                endingYear: _endingYear.text,
                                rollNumber: _rollNumber.text,
                                Number: _number.text,
                                startingYear: _startingYear.text,
                                uid: currentUser.uid,
                                tag: _tag.toUpperCase(),
                                branch: _branch,
                                username: (_name.text).split(" ")[0],
                                chattingPartners: [],
                                SubAdmin: 'UNSUB',
                                skill: _skill.text,
                              );

                              _repository
                                  .addUserDataToDB(myUser, currentUser)
                                  .then(
                                (value) {
                                  _repository
                                      .getPosts()
                                      .then((List<QueryDocumentSnapshot> list) {
                                    setState(
                                      () {
                                        _shouldIRotate = false;
                                      },
                                    );
                                    
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => OtpScreen(value),
                                    //   ),
                                    // );
                                    _repository.sendMail().then((value) {
                                      if (value) {
                                        print("sent mail");
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OtpScreen(list),
                                          ),
                                        );
                                      } else {
                                        print("There was some error");
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                "Invalid Email or check your internet connection",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              backgroundColor: Colors.white),
                                        );
                                      }
                                    });
                                  });
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            _shouldIRotate
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator()))
                : Container(),
          ],
        ),
      ),
    );
  }
}
