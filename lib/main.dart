import 'buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

String userQuestion = '';
String userAnswer = '';
String tempA = '';

double fontSize = 30;

List history = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('History'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              tooltip: 'Delete History',
              icon: Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => AlertDialog(
                          title: Text('Delete History'),
                          backgroundColor: Colors.teal[300],
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Do you want to delete your history of calculations?')
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                                child: Text('Decline',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            TextButton(
                              child: Text('Approve',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                setState(() {
                                  history.clear();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.teal[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(history[index]),
                    )
                  ],
                ),
              );
            }));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myTextStyle = TextStyle(fontSize: fontSize, color: Colors.teal[300]);

  final List<String> buttons = [
    'History',
    'Scientific Calculator',
    'C',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion,
                          style: TextStyle(
                              fontSize: fontSize, color: Colors.teal[900])),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(
                          fontSize: fontSize, color: Colors.teal[900]),
                    ),
                  )
                ],
              ),
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 2) {
                  return MyButton(
                      buttonTapped: () {
                        tempA = userAnswer;
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white);
                }

                // Delete Button
                else if (index == 3) {
                  return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white);
                }

                // Equal Button
                else if (index == 20) {
                  return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.teal[300],
                      textColor: Colors.white);
                }

                // ANS Button
                else if (index == 21) {
                  return MyButton(
                      buttonTapped: () {
                        var temp = userQuestion.length + userAnswer.length;
                        if (temp > 17) {
                          setState(() {
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Maximum number of digits (17) exceeded.')));
                          });
                        } else {
                          setState(() {
                            userQuestion += tempA;
                          });
                        }
                      },
                      buttonText: buttons[index],
                      color: Colors.teal[300],
                      textColor: Colors.white);
                }

                // Rest of the buttons
                else {
                  return MyButton(
                      buttonTapped: () {
                        if (userQuestion.length >= 17) {
                          setState(() {
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Maximum number of digits (17) exceeded.')));
                          });
                        } else {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        }
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.teal[300]
                          : Colors.teal,
                      textColor: Colors.white);
                }
              }),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '÷' || x == '×' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('%', '*0.01');
    finalQuestion = finalQuestion.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();

    history.add(userQuestion);
  }
}
