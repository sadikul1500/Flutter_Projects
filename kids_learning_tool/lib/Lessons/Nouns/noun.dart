import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_libwinmedia/just_audio_libwinmedia.dart';
import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_card.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_search_bar.dart';
//import 'package:kplayer/kplayer.dart';

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
  AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState? _state;
  //late Player player;

  Widget _nounCard() {
    if (imageList.isEmpty) {
      print('if..');
      loadData();
      return const CircularProgressIndicator();
    } else if (_state?.processingState != ProcessingState.ready) {
      print('else if');
      loadAudio();
      print('audio called');
      return const CircularProgressIndicator();
    } else {
      print('noun card is not invoked 1...');
      print(_audioPlayer.toString());
      //_audioPlayer.play();
      return NounCard(names.elementAt(_index), _audioPlayer);
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
      //if (data) {
      setState(() {
        //imageList = data;
        //len = names.length;
      });
      //}
    });

    loadAudio().then((data) {
      //print(data);
      print('newwww');
      setState(() {
        // _audioPlayer = data;
      });
    });
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _state = state;
      });
      print(100);
      print(_state?.processingState);
    });
    //player = Player.
  }

  Future loadData() async {
    print('loadData1');
    await Future.delayed(const Duration(milliseconds: 270));
    print('loaddata11');
    //

    //print('11');

    names = nameList.getList();
    // print(1233);
    // print(names);
    if (names.isEmpty) {
      print('didn\'t loaded');
      return [];
    }
    print(names);
    len = names.length;
    imageList = names[_index].imgList;
    //return names[_index].imgList;
  }

  Future loadAudio() async {
    await Future.delayed(const Duration(milliseconds: 100));
    await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.file(names[_index].audio)),
        initialPosition: Duration.zero,
        preload: true);
    print('await call finished');
    _audioPlayer.play();
    return _audioPlayer;
  }

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');

        //trigger leaving and use own data
        //
        _audioPlayer.pause();

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Noun'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  var result = await showSearch<String>(
                    context: context,
                    delegate: CustomDelegate(names),
                  );
                  setState(() {
                    _audioPlayer.stop();
                    _index = max(0,
                        names.indexWhere((element) => element.text == result));
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
            setState(() {
              _audioPlayer.stop();
            });
            Navigator.pushNamed(
                context, '/nounForm'); //.then((_) => setState(() {
            //       Noun();
            //     }));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add a Noun',
              style: TextStyle(
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
