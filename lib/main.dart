import 'buttons.dart';
import 'drawer.dart';
import 'theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

var userQuestion = '';
var userAnswer = '';

var userQuestion2 = '';
var userAnswer2 = '';

bool _darktheme =
    false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(builder: (context, _brightness) {
      return MaterialApp(
          theme: ThemeData(brightness: _brightness),
          debugShowCheckedModeBanner: false,
          home: HomePage());
    });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
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
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      drawer: drawer(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion,
                        style:
                            TextStyle(fontSize: 30, color: Colors.deepPurple)),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 30, color: Colors.deepPurple),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  primary: false,
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
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
                        textColor: Colors.white,
                      );
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
                        textColor: Colors.white,
                      );
                    }

                    // Equal Button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    }

                    // Rest of the buttons
                    else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '×' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('%', '*0.01');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}

class SCalculator extends StatefulWidget {
  @override
  _SCalculatorState createState() => _SCalculatorState();
}

class _SCalculatorState extends State<SCalculator> {
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C',
    'DEL',
    '!',
    'sin',
    '7',
    '8',
    '9',
    'cos',
    '4',
    '5',
    '6',
    'tan',
    '1',
    '2',
    '3',
    'log',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      drawer: drawer(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion2,
                        style:
                            TextStyle(fontSize: 30, color: Colors.deepPurple)),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer2,
                      style: TextStyle(fontSize: 30, color: Colors.deepPurple),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  primary: false,
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion2 = '';
                            userAnswer2 = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }

                    // Delete Button
                    else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion2 = userQuestion2.substring(
                                0, userQuestion2.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    }

                    // Equal Button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    }

                    // Rest of the buttons
                    else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion2 += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '!' ||
        x == 'sin' ||
        x == 'cos' ||
        x == 'tan' ||
        x == 'log' ||
        x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion2 = userQuestion2;
    finalQuestion2 = finalQuestion2.replaceAll('×', '*');
    finalQuestion2 = finalQuestion2.replaceAll('%', '*0.01');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion2);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer2 = eval.toString();
  }
}

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  void changeTheme() {
    ThemeBuilder.of(context).changeTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[200]),
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        SwitchListTile(
          title: Text('Dark Theme'),
          value:
              _darktheme, // the is actually useless, but 'SwitchListTile' and 'onChanged' require it
          onChanged: (bool value) {
            setState(() {
              _darktheme =
                  value; // the is actually useless, but 'SwitchListTile' and 'onChanged' require it
              changeTheme();
            });
          },
          secondary: Icon(Icons.account_circle_rounded),
        ),
      ]),
    );
  }
}
