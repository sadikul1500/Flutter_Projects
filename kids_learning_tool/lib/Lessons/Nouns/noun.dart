import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_card.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_search_bar.dart';

class Noun extends StatefulWidget {
  @override
  State<Noun> createState() => _NounState();
}

class _NounState extends State<Noun> {
  List<Name> names = [
    Name('Umbrella', 'ছাতা'),
    Name('Apple', 'আপেল'),
    Name('Car', 'গাড়ি'),
    Name('Deer', 'হরিণ'),
  ];
  int index = 0;
  late int len;

  @override
  void initState() {
    super.initState();
    names.sort((a, b) => a.text.compareTo(b.text));
    len = names.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NounCard(name: names.elementAt(index)),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    index = (index - 1) % len;
                  });
                },
                label: const Text(
                  'Prev',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                icon: const Icon(
                  Icons.navigate_before,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    index = (index + 1) % len;
                  });
                },
                child: Row(
                  children: <Widget>[
                    const Text('Next',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    const Icon(Icons.navigate_next),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add a Noun',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}

// const Text('Noun page')

// AppBar(
//         title: const Text('Nouns',
//             style: TextStyle(
//               fontSize: 24,
//             )),
//         centerTitle: true,
//       ),
