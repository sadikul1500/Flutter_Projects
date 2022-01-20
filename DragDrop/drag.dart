import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/itemModel.dart';

class Drag extends StatefulWidget {
  @override
  State<Drag> createState() => DragState();
}

class DragState extends State<Drag> {
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];

  int score = 0;
  bool gameOver = false;

  void init() {
    super.initState();
    initDrag();
  }

  void initDrag() {
    List<ItemModel> items = [
      ItemModel('Coffee', 'Coffee', FontAwesomeIcons.coffee),
      ItemModel('Apple', 'Apple', FontAwesomeIcons.apple),
      ItemModel('Calender', 'Calender', FontAwesomeIcons.calendar),
      ItemModel('Bus', 'Bus', FontAwesomeIcons.bus),
    ];
    List<ItemModel> items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(centerTitle: true, title: const Text('Drag & drop')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(children: [
              const TextSpan(text: 'Score: '),
              TextSpan(text: '$score'),
            ]))
          ],
        ),
      ),
    );
  }
}
