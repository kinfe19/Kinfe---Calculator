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

double fontSize = 30;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myTextStyle = TextStyle(fontSize: fontSize, color: Colors.teal[300]);

  final List<String> buttons = [
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
                if (index == 0) {
                  return MyButton(
                      buttonTapped: () {
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
                else if (index == 1) {
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
                else if (index == 19) {
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
                else if (index == 18) {
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
                            userQuestion += userAnswer;
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
  }
}
