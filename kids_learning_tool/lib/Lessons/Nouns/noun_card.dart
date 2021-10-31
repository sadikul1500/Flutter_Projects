import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_card.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_search_bar.dart';

class Noun extends StatefulWidget {
  @override
  State<Noun> createState() => _NounState();
}

class _NounState extends State<Noun> {
  NameList nameList = NameList();
  late List<Name> names;
  int _index = 0;
  late int len;
  List<String> imageList = [];

  Widget _nounCard() {
    if (imageList.isEmpty) {
      loadData();
      return const CircularProgressIndicator();
    } else {
      print('noun card is not invoked 1...');
      return NounCard(names.elementAt(_index), 0);
    }
  }

  _NounState() {
    _index = 0;
    //nameList = NameList();
  }

  @override
  initState() {
    // names = nameList.getList();
    // len = names.length;

    _nounCard();
    super.initState();

    loadData().then((data) {
      setState(() {
        imageList = data;
        len = names.length;
      });
    });
  }

  Future loadData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    names = nameList.getList();
    // print(1233);
    // print(names);
    if (names.isEmpty) {
      return [];
    }
    return names[_index].imgList;
  }

  // Future loading() async {
  //   //await Future.delayed(const Duration(milliseconds: 100));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Noun'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                // print(500);
                // names.forEach((element) {
                //   print(element.text);
                // });
                // print(names.length);
                var result = await showSearch<String>(
                  context: context,
                  delegate: CustomDelegate(names),
                );
                setState(() {
                  _index = max(
                      0, names.indexWhere((element) => element.text == result));
                  //_result = result;
                });
              }, //Navigator.pushNamed(context, '/searchPage'),
              // onPressed: () => Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: const SafeArea(child: Icon(Icons.search_sharp)))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //resizeTo
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //NounCard(name: names.elementAt(_index)),
            _nounCard(),

            //NounCard(name: names.elementAt(_index)),

            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      //loading();
                      _index = (_index - 1) % len;
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
                      //loading();
                      _index = (_index + 1) % len;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      const Text('Next',
                          style: TextStyle(
                            fontSize: 21,
                          )),
                      const Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/nounForm');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add a Noun',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
    );
  }
}
