import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Quiz/Matching/question.dart';

class Preview extends StatefulWidget {
  final Question question;
  Preview(this.question);

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
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        padding: const EdgeInsets.fromLTRB(250, 150, 250, 0),
        color: Colors.white.withOpacity(0.80),
        child: Align(
            alignment: const Alignment(0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                )
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
