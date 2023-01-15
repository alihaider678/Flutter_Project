import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniproject/pages/quiz.dart';

class QuizAnyTable extends StatefulWidget {
  const QuizAnyTable({Key? key}) : super(key: key);

  @override
  State<QuizAnyTable> createState() => _QuizAnyTableState();
}

class _QuizAnyTableState extends State<QuizAnyTable> {
  @override
  User? current = FirebaseAuth.instance.currentUser;
  int? qnumber;

  List<int> question_list = List<int>.generate(10, (index) => index + 1);
  final TextEditingController tablenumber = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  bool button = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'List of tables',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: tablenumber,
                decoration: InputDecoration(
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Enter table number",
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  contentPadding: EdgeInsets.all(15.0),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter table number';
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Enter Question?",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Spacer(),
                      DropdownButton<int>(
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: false,
                        value: qnumber ?? 1,
                        items: question_list
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(
                                    e.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            qnumber = value;
                            button = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              button == false
                  ? SizedBox(
                      height: 0,
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Container(
                        width: double.infinity,
                        child: MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quiz(
                                        table: int.parse(tablenumber.text),
                                        questNum: qnumber ?? 3)),
                              );
                            }
                          },
                          child: Text(
                            "Generate Quiz",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
