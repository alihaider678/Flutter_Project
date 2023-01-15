import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniproject/pages/Login.dart';
import 'package:uniproject/pages/table_generate.dart';

class Home extends StatefulWidget {
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tablevalue = 0;
  bool isstart = false;
  int? pre, snumber, enumber;

  List<int> items = List<int>.generate(10, (index) => index + 1);
  List<int> items2 = List<int>.generate(10, (index) => index + 1);
  bool generateNumber = false;
  bool a = false;
  final TextEditingController tablenumber = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Future _showDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("LogOut"),
            content: Text("Are you sure to log out?"),
            actions: [
              MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text("Yes")),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _showDialog();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
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
                            hintText: "Enter Table number",
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text(
                                  "Starting",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Spacer(),
                                DropdownButton<int>(
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  isExpanded: false,
                                  value: snumber ?? 1,
                                  items: items
                                      .map((e) => DropdownMenuItem<int>(
                                            value: e,
                                            child: Text(
                                              e.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      snumber = value;
                                      generateNumber = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        generateNumber == true
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Ending",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Spacer(),
                                      DropdownButton<int>(
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        isExpanded: false,
                                        value: enumber ?? 1,
                                        items: items2
                                            .map((e) => DropdownMenuItem<int>(
                                                  value: e,
                                                  child: Text(
                                                    e.toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            enumber = value;
                                            a = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        a == true
                            ? Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TableGenerate(
                                                      start: snumber ?? 0,
                                                      end: enumber ?? 0,
                                                      tablenumber: int.parse(
                                                          tablenumber.text))),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Generate Table',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
