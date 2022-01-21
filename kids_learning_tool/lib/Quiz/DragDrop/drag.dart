//https://www.youtube.com/watch?v=pwkDaGbYuu8&ab_channel=TechiePraveen
import 'package:assets_audio_player/assets_audio_player.dart';
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
  //final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    initDrag();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  initDrag() {
    score = 0;
    gameOver = false;
    _audioPlayer.setAsset('assets/Audios/win.wav');
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
                            const EdgeInsets.fromLTRB(100.0, 10.0, 25.0, 8.0),
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
                      return Container(
                        margin: const EdgeInsets.fromLTRB(25, 10, 100, 8.0),
                        child: DragTarget<ItemModel>(
                          onAccept: (receivedItem) {
                            if (item.value == receivedItem.value) {
                              setState(() {
                                //_audioPlayer.seek(Duration.zero);
                                //receivedItem.icon = FontAwesomeIcons.check;
                                //item.name = 'Correct!';
                                //item.value = '#x';
                                // try {
                                //   assetsAudioPlayer.open(
                                //     Audio("assets/Audios/win.wav"),
                                //     autoStart: true,
                                //   );
                                // } catch (e) {
                                //   print(e);
                                // }
                                //_audioPlayer.setAsset('assets/Audios/win.wav');
                                _audioPlayer.play();
                                items.remove(receivedItem);
                                items2.remove(item);
                                dispose();
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
