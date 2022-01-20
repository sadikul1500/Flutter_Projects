//https://www.youtube.com/watch?v=pwkDaGbYuu8&ab_channel=TechiePraveen
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/itemModel.dart';

class Drag extends StatefulWidget {
  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];

  int score = 0;
  //int total = 0;
  bool gameOver = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initDrag();
  }

  initDrag() {
    score = 0;
    gameOver = false;
    _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.file(
            'D:/Sadi/FlutterProjects/kids_learning_tool/assets/Audios/win.wav')),
        initialPosition: Duration.zero,
        preload: true);
    items = [
      ItemModel('Coffee', 'Coffee', FontAwesomeIcons.coffee),
      ItemModel('Apple', 'Apple', FontAwesomeIcons.apple),
      ItemModel('Calender', 'Calender', FontAwesomeIcons.calendar),
      ItemModel('Bus', 'Bus', FontAwesomeIcons.bus),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
    //total = items.length;
  }

  @override
  Widget build(BuildContext context) {
    if (score == items.length + score) {
      gameOver = true;
    }
    return Scaffold(
      //backgroundColor: Colors.amber[300],
      appBar: AppBar(centerTitle: true, title: const Text('Drag & drop')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: 'Score: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              TextSpan(
                  text: '$score / ${items.length + score}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 27)),
            ])),
            if (gameOver == false)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: items.map((item) {
                      return Container(
                        margin:
                            const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        child: Draggable<ItemModel>(
                          data: item,
                          childWhenDragging: Icon(
                            item.icon,
                            color: Colors.grey,
                            size: 50.0,
                          ),
                          feedback:
                              Icon(item.icon, color: Colors.blue, size: 50),
                          child: Icon(item.icon, color: Colors.blue, size: 50),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  //const Text('hi'),
                  Column(
                    children: items2.map((item) {
                      return DragTarget<ItemModel>(
                        onAccept: (receivedItem) {
                          if (item.value == receivedItem.value) {
                            setState(() {
                              _audioPlayer.seek(Duration.zero);
                              //receivedItem.icon = FontAwesomeIcons.check;
                              //item.name = 'Correct!';
                              //item.value = '#x';
                              items.remove(receivedItem);
                              items2.remove(item);
                              _audioPlayer.play();
                              score += 1;
                              item.accepting = false;
                            });
                          } else {
                            setState(() {
                              //score -= 1;
                              item.accepting = false;
                            });
                          }
                        },
                        onLeave: (receivedItem) {
                          setState(() {
                            item.accepting = false;
                          });
                        },
                        onWillAccept: (receivedItem) {
                          setState(() {
                            item.accepting = true;
                          });
                          return true;
                        },
                        builder: (context, acceptedItem, rejectedItem) =>
                            Container(
                          color: item.accepting ? Colors.red : Colors.blue,
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(8.0),
                          child: Text(item.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            if (gameOver)
              Column(
                children: <Widget>[
                  const Text('Quiz Complete !!!',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 60), elevation: 3),
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        initDrag();
                        setState(() {});
                      },
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Matching Game",
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<ItemModel> items = [];
//   List<ItemModel> items2 = [];

//   int score = 0;
//   bool gameOver = false;

//   @override
//   void initState() {
//     super.initState();
//     initGame();
//   }

//   initGame() {
//     gameOver = false;
//     score = 0;
//     items = [
//       ItemModel(icon: FontAwesomeIcons.coffee, name: "Coffee", value: "Coffee"),
//       ItemModel(icon: FontAwesomeIcons.dog, name: "dog", value: "dog"),
//       ItemModel(icon: FontAwesomeIcons.cat, name: "Cat", value: "Cat"),
//       ItemModel(
//           icon: FontAwesomeIcons.birthdayCake, name: "Cake", value: "Cake"),
//       ItemModel(icon: FontAwesomeIcons.bus, name: "bus", value: "bus"),
//     ];
//     items2 = List<ItemModel>.from(items);
//     items.shuffle();
//     items2.shuffle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) gameOver = true;
//     return Scaffold(
//       //backgroundColor: Colors.amber,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Matching Game'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Text.rich(TextSpan(children: [
//               TextSpan(text: "Score: "),
//               TextSpan(
//                   text: "$score",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30.0,
//                   ))
//             ])),
//             if (!gameOver)
//               Row(
//                 children: <Widget>[
//                   Column(
//                       children: items.map((item) {
//                     return Container(
//                       margin: const EdgeInsets.all(8.0),
//                       child: Draggable<ItemModel>(
//                         data: item,
//                         childWhenDragging: Icon(
//                           item.icon,
//                           color: Colors.grey,
//                           size: 50.0,
//                         ),
//                         feedback: Icon(
//                           item.icon,
//                           color: Colors.black,
//                           size: 50,
//                         ),
//                         child: Icon(
//                           item.icon,
//                           color: Colors.black,
//                           size: 50,
//                         ),
//                       ),
//                     );
//                   }).toList()),
//                   Spacer(),
//                   Column(
//                       children: items2.map((item) {
//                     return DragTarget<ItemModel>(
//                       onAccept: (receivedItem) {
//                         if (item.value == receivedItem.value) {
//                           setState(() {
//                             items.remove(receivedItem);
//                             items2.remove(item);
//                             score += 10;
//                             item.accepting = false;
//                           });
//                         } else {
//                           setState(() {
//                             score -= 5;
//                             item.accepting = false;
//                           });
//                         }
//                       },
//                       onLeave: (receivedItem) {
//                         setState(() {
//                           item.accepting = false;
//                         });
//                       },
//                       onWillAccept: (receivedItem) {
//                         setState(() {
//                           item.accepting = true;
//                         });
//                         return true;
//                       },
//                       builder: (context, acceptedItems, rejectedItem) =>
//                           Container(
//                         color: item.accepting ? Colors.red : Colors.teal,
//                         height: 50,
//                         width: 100,
//                         alignment: Alignment.center,
//                         margin: const EdgeInsets.all(8.0),
//                         child: Text(
//                           item.name,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0),
//                         ),
//                       ),
//                     );
//                   }).toList()),
//                 ],
//               ),
//             if (gameOver)
//               Text(
//                 "GameOver",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0,
//                 ),
//               ),
//             if (gameOver)
//               Center(
//                 child: RaisedButton(
//                   textColor: Colors.white,
//                   color: Colors.pink,
//                   child: Text("New Game"),
//                   onPressed: () {
//                     initGame();
//                     setState(() {});
//                   },
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ItemModel {
//   final String name;
//   final String value;
//   final IconData icon;
//   bool accepting;

//   ItemModel(
//       {required this.name,
//       required this.value,
//       required this.icon,
//       this.accepting = false});
// }
