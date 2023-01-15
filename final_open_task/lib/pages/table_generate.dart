import 'package:flutter/material.dart';
import 'package:uniproject/pages/Home.dart';
import 'package:uniproject/pages/quiz_any_table.dart';

class TableGenerate extends StatefulWidget {
  final int tablenumber;
  final int start;
  final int end;
  const TableGenerate(
      {Key? key,
      required this.start,
      required this.end,
      required this.tablenumber})
      : super(key: key);

  @override
  State<TableGenerate> createState() => _TableGenerateState();
}

class _TableGenerateState extends State<TableGenerate> {
  @override
  List<String> table = [" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "];
  int _tablevalue = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      for (int i = widget.start; i < widget.end; i++) {
        String col1 = widget.tablenumber.toString();
        String col2 = (i + 1).toString();
        String col3 = (widget.tablenumber * (i + 1)).toString();
        String sliderNum = col1 + "  *  ";
        String limit = sliderNum + col2;
        String equl = limit + " = ";
        String ans = equl + col3;
        table[i] = ans;
        if (i == 10) {
          table[10] = "Take Quiz";
        }
      }
      _tablevalue = widget.tablenumber;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Table"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 150,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Table of ${widget.tablenumber.toString()}",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              Text(
                table[0],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[1],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[2],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[3],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[4],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[5],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[6],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[7],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[8],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                table[9],
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Text(
                          "Generate Again",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {
                          // Random random = new Random();
                          // int randomNumber = random.nextInt(10);
                          // DataModel.checkerNumber = randomNumber;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizAnyTable()),
                          );
                        },
                        child: Text(
                          "Start Quiz With any Table",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
