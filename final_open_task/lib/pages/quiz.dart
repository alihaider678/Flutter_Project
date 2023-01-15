import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniproject/pages/result_show.dart';

class Quiz extends StatefulWidget {
  Quiz({required this.table, required this.questNum});
  final int table;
  final int questNum;

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // MemoDbProvider memoDb = MemoDbProvider();
  User? current = FirebaseAuth.instance.currentUser;
  Random r1 = new Random();
  List<String> quiz = [];
  int random = 0;
  int opa = 0;
  int opb = 0;
  int opc = 0;
  int ope = 0;
  int priority = 0;
  int table = 0;
  int chang = 1;
  bool clr1 = true;
  bool clr2 = true;
  bool clr3 = true;
  bool clr4 = true;
  bool a1 = false;
  bool a2 = false;
  bool a3 = false;
  bool a4 = false;

  bool buttonshow = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      table = widget.table;
      random = r1.nextInt(10) + 1;
      opa = r1.nextInt(4) + 1;
      opb = r1.nextInt(8) + 5;
      opc = r1.nextInt(12) + 9;
      ope = r1.nextInt(16) + 13;
      priority = r1.nextInt(4) + 1;

      buttonshow = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            chang != widget.questNum
                ? Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Question #",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                chang.toString(),
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "$table x $random = _____",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Visibility(
                          visible: buttonshow,
                          child: TextButton(
                              child: (priority == 1)
                                  ? Text(
                                      "Option ${table * random}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text("Option ${(table * random) + opa}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                              onPressed: () {
                                setState(() {
                                  if (priority == 1) {
                                    a1 = true;
                                    clr1 = false;
                                  } else {
                                    clr1 = false;
                                    if (priority == 2) {
                                      a2 = true;
                                      clr2 = false;
                                    } else if (priority == 3) {
                                      a3 = true;
                                      clr3 = false;
                                    } else if (priority == 4) {
                                      a4 = true;
                                      clr4 = false;
                                    }
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: clr1
                                      ? (Colors.white)
                                      : (a1 ? Colors.green : Colors.red))),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      SizedBox(
                        child: Visibility(
                          visible: buttonshow,
                          child: TextButton(
                              child: (priority == 2)
                                  ? Text(" Option ${table * random}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                  : Text(" Option ${(table * random) + opb}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                              onPressed: () {
                                setState(() {
                                  if (priority == 2) {
                                    a2 = true;
                                    clr2 = false;
                                  } else {
                                    clr2 = false;
                                    if (priority == 1) {
                                      a1 = true;
                                      clr1 = false;
                                    } else if (priority == 3) {
                                      a3 = true;
                                      clr3 = false;
                                    } else if (priority == 4) {
                                      a4 = true;
                                      clr4 = false;
                                    }
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: clr2
                                      ? (Colors.white)
                                      : (a2 ? Colors.green : Colors.red))),
                        ),
                      ),
                      SizedBox(
                        child: Visibility(
                          visible: buttonshow,
                          child: TextButton(
                              child: (priority == 3)
                                  ? Text("Option ${table * random}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                  : Text("Option ${(table * random) + opc}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                              onPressed: () {
                                setState(() {
                                  if (priority == 3) {
                                    a3 = true;
                                    clr3 = false;
                                  } else {
                                    clr3 = false;
                                    if (priority == 2) {
                                      a2 = true;
                                      clr2 = false;
                                    } else if (priority == 1) {
                                      a1 = true;
                                      clr1 = false;
                                    } else if (priority == 4) {
                                      a4 = true;
                                      clr4 = false;
                                    }
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: clr3
                                      ? (Colors.white)
                                      : (a3 ? Colors.green : Colors.red))),
                        ),
                      ),
                      SizedBox(
                        child: Visibility(
                          visible: buttonshow,
                          child: TextButton(
                              child: (priority == 4)
                                  ? Text("Option ${table * random}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                  : Text("Option ${(table * random) + ope}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                              onPressed: () {
                                setState(() {
                                  if (priority == 4) {
                                    a4 = true;
                                    clr4 = false;
                                  } else {
                                    clr4 = false;
                                    if (priority == 2) {
                                      a2 = true;
                                      clr2 = false;
                                    } else if (priority == 3) {
                                      a3 = true;
                                      clr3 = false;
                                    } else if (priority == 1) {
                                      a1 = true;
                                      clr1 = false;
                                    }
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: clr4
                                      ? (Colors.white)
                                      : (a4 ? Colors.green : Colors.red))),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
            Visibility(
              visible: buttonshow,
              child: chang == widget.questNum
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width - 200,
                              child: MaterialButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () async {
                                  // final memo = QuizModel(
                                  //   id: 1,
                                  //   totalquestion: data.length.toString(),
                                  //   right: countBoolList(data).toString(),
                                  //   wrong: countBoolFalseList(data).toString(),
                                  // );
                                  //
                                  // await memoDb.addItem(memo);
                                  // var memos = await memoDb.fetchMemos();

                                  FirebaseFirestore.instance
                                      .collection("ali")
                                      .doc(current?.uid)
                                      .collection('data')
                                      .add({
                                    "quiz": quiz,
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OnlineResult()));
                                },
                                child: Text("Show Result as offline",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width - 200,
                              child: MaterialButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("ali")
                                      .doc(current?.uid)
                                      .collection('data')
                                      .add({
                                    "quiz": quiz,
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OnlineResult()));
                                },
                                child: Text("Show Result as Online",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width - 200,
                          child: MaterialButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              setState(() {
                                quiz.add(
                                    "${table}  *  ${random} = ${table * random}");
                                random = r1.nextInt(10) + 1;
                                priority = r1.nextInt(4) + 1;
                                clr1 = true;
                                clr2 = true;
                                clr3 = true;
                                clr4 = true;
                                a1 = false;
                                a2 = false;
                                a3 = false;
                                a4 = false;
                                chang++;
                              });
                            },
                            child: Text("Next Question",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
