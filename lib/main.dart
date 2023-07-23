import 'package:calculator/buttonCard.dart';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple.shade100,
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Object isOperator(String s) {
    if (s == '/' || s == '*' || s == '-' || s == '+' || s == '%') {
      return Colors.purple;
    } else {
      return Colors.white;
    }
    print('hello');
  }

  Object isOperatorTextColor(String s) {
    if (s == '/' || s == '*' || s == '-' || s == '+' || s == '%') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  List buttonText = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  // const Calculator({super.key});
  var userQuestion = '';
  var userAnswer = '';

  void onTap(String str) {
    setState(() {
      if (str == 'C') {
        userQuestion = '';
        userAnswer = '';
      } else if (str == 'DEL') {
        userQuestion = userQuestion.substring(0, userQuestion.length - 1);
      } else {
        userQuestion += str;
      }
    });
  }

  void equalPressed() {
    var finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment(0.85, 0.5),
                    child: Text(
                      userQuestion,
                      style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0.85, 0.5),
                    child: Text(
                      userAnswer,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: GridView.builder(
                itemCount: buttonText.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, index) {
                  //for C
                  if (index == 0) {
                    return buttonCard(
                      btncolor: Colors.green,
                      text: buttonText[index],
                      textColor: Colors.white,
                      ontap: () {
                        onTap(buttonText[index]);
                      },
                    );
                    //for DEL
                  } else if (index == 1) {
                    return buttonCard(
                        btncolor: Colors.red,
                        text: buttonText[index],
                        textColor: Colors.white,
                        ontap: () {
                          onTap(buttonText[index]);
                        });
                  }
                  // for =
                  else if (index == buttonText.length - 1) {
                    return buttonCard(
                        btncolor: Colors.purple,
                        text: buttonText[index],
                        textColor: Colors.white,
                        ontap: () {
                          // onTap(buttonText[index]);
                          setState(() {
                            equalPressed();
                          });
                        });
                  } else {
                    return buttonCard(
                      btncolor: isOperator(buttonText[index]),
                      textColor: isOperatorTextColor(buttonText[index]),
                      text: buttonText[index].toString(),
                      ontap: () {
                        onTap(buttonText[index]);
                      },
                    );
                  }
                }),
          ),
        )
      ],
    );
  }
}
