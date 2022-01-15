import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Quiz/Matching/question.dart';

class Preview extends StatefulWidget {
  final Question question;
  const Preview(this.question);

  @override
  State<Preview> createState() => PreviewState();
}

class PreviewState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    // Here you direct access using widget
    //return Text(widget.question);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Test: Matching'),
        centerTitle: true,
      ),
      body: MyStatefulWidget(widget.question),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  //const MyStatefulWidget({Key? key}) : super(key: key);
  final Question question;
  const MyStatefulWidget(this.question);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late Timer _timer;
  int _start = 0;
  bool hasPressed = false;
  bool isCorrect = false;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _start++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        Navigator.pop(context);
        //we need to return a future
        return Future.value(false);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(250, 50, 250, 0),
        color: Colors.white.withOpacity(0.80),
        child: Align(
            alignment: const Alignment(0, 0),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: const Text('Start')),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                  child: Text('$_start'),
                ),
                SizedBox(
                    height: 300,
                    width: 400,
                    child: Image.file(
                      File(widget.question.imagePath),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    )),
                const SizedBox(height: 10),
                Text(widget.question.ques),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (widget.question.correctAnswer == 'A') {
                          setState(() {
                            isCorrect = true;
                          });
                        }
                      },
                      child: Text('A. ' + widget.question.options[0]),
                      style: ElevatedButton.styleFrom(
                          primary: hasPressed
                              ? (isCorrect ? Colors.green : Colors.red)
                              : Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.question.correctAnswer == 'B') {
                          setState(() {
                            isCorrect = true;
                          });
                        }
                      },
                      child: Text('B. ' + widget.question.options[1]),
                      style: ElevatedButton.styleFrom(
                          primary: hasPressed
                              ? (isCorrect ? Colors.green : Colors.red)
                              : Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (widget.question.correctAnswer == 'C') {
                          setState(() {
                            isCorrect = true;
                          });
                        }
                      },
                      child: Text('C. ' + widget.question.options[2]),
                      style: ElevatedButton.styleFrom(
                          primary: hasPressed
                              ? (isCorrect ? Colors.green : Colors.red)
                              : Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.question.correctAnswer == 'D') {
                          setState(() {
                            isCorrect = true;
                          });
                        }
                      },
                      child: Text('D. ' + widget.question.options[3]),
                      style: ElevatedButton.styleFrom(
                          primary: hasPressed
                              ? (isCorrect ? Colors.green : Colors.red)
                              : Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:async';

// void main(){
//   runApp(MaterialApp(home:Noun()));
// }

// class Noun extends StatefulWidget {
//   @override
//   State<Noun> createState() => _NounState();
// }

// class _NounState extends State<Noun> {

// late Timer _timer;
// int _start = 0;

// void startTimer() {

//   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

//         setState(() {
//           _start++;
//         });

//     });

// }

//   Widget build(BuildContext context) {
//    //startTimer();
//   return  Scaffold(
//     //startTimer(),
//     appBar: AppBar(title: const Text("Timer test")),
//     body: Column(
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: () {
//             startTimer();
//           },
//           child: const Text("start"),
//         ),
//         Text("$_start"),
//         ElevatedButton(
//           onPressed: () {

//               _timer.cancel();

//           },
//           child: const Text("stop"),
//         ),
//       ],
//     ),
//   );
// }

// }
