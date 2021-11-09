import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_libwinmedia/just_audio_libwinmedia.dart';
import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_card.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_search_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
  final CarouselController _controller = CarouselController();
  int activateIndex = 0;

  bool _isPlaying = false;
  bool _isPaused = false;

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
      print(_index);
      // setState(() {  //not needed here
      //   _audioPlayer.play();
      // });
      return nounCardWidget(); //NounCard(names.elementAt(_index), _audioPlayer);
    }
  }

  _NounState() {
    _index = 0;
  }

  @override
  initState() {
    loadData().then((List<String> value) {
      print('then1');
      loadAudio().then((value) {
        print('then2');
        _nounCard();
      });
    });
    //_nounCard();

    // loadData().then((data) {
    //   //if (data) {
    //   setState(() {
    //     //imageList = data;
    //     //len = names.length;
    //   });
    //   //}
    // });

    // loadAudio().then((data) {
    //   setState(() {
    //     // _audioPlayer = data;
    //   });
    // });
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _state = state;
      });
      print(100);
      print(_state?.processingState);
    });
    super.initState();
    //player = Player.
  }

  Future<List<String>> loadData() async {
    names = nameList.getList();
    // print(names);

    if (names.isEmpty) {
      print('didn\'t loaded');
      await Future.delayed(const Duration(milliseconds: 240));
      return [];
    }

    for (Name name in names) {
      print(name.text + ' ' + name.audio);
    }

    len = names.length;
    imageList = names[_index].imgList;
    print('image List created');
    return imageList;
    //return names[_index].imgList;
  }

  Future loadAudio() async {
    //await Future.delayed(const Duration(milliseconds: 20)); //not needed
    //print(names[_index].audio);
    print('index ' + '$_index' + ' length ' + '${names.length}');
    await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.file(names[_index].audio)),
        initialPosition: Duration.zero,
        preload: true);
    print('load audio function done');

    _audioPlayer.setLoopMode(LoopMode.one);
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
        stop();
        setState(() {
          print('audio payer stopped before going back from noun.dart');
          // _audioPlayer.stop();
        });

        Navigator.pop(context);
        // Navigator.pop(context);
        // Navigator.pushNamed(context, '/home');

        //we need to return a future
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Noun'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  stop();
                  setState(() {
                    print('stopped while clicking search ');
                    // _audioPlayer.stop();
                  });
                  var result = await showSearch<String>(
                    context: context,
                    delegate: CustomDelegate(names),
                  );
                  setState(() {
                    //_audioPlayer.stop();
                    _index = max(0,
                        names.indexWhere((element) => element.text == result));
                    //_audioPlayer.play();
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
              _nounCard(),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      print('prev');
                      //print(_state?.processingState);
                      //_audioPlayer.stop();
                      stop();

                      setState(() {
                        //loading();

                        _isPlaying = false;

                        _index = (_index - 1) % len;
                        //print(_state?.processingState);
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
                  const SizedBox(width: 30),
                  IconButton(
                    icon: (_isPlaying)
                        ? Icon(Icons.pause_circle_filled)
                        : Icon(Icons.play_circle_outline),
                    iconSize: 40,
                    onPressed: () => _isPlaying
                        ? stop()
                        : _isPaused
                            ? play()
                            : stop(),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      print('next');
                      //print(_state);
                      //_audioPlayer.stop();
                      stop();
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
            // setState(() {
            stop();
            // });
            // Navigator.pushNamed(
            //     context, '/nounForm').then((value) { setState(() {}); //.then((_) => setState(() {
            //       Noun();
            //     }));
            Navigator.of(context)
                .pushNamed('/nounForm')
                .then((value) => setState(() {}));
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

  Future stop() async {
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _isPaused = true;
    });
  }

  Future play() async {
    _audioPlayer.play();
    // if (result == 1) {
    setState(() {
      _isPlaying = true;
      _isPaused = false;
    });
    //}
  }

  Widget nounCardWidget() {
    Name name = names.elementAt(_index);
    List<String> images = name.getImgList();
    print('noun card widget');
    print(_index);
    print(name.text);

    // setState(() {
    //   _audioPlayer.play();
    // });
    //
    //_audioPlayer.play();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Noun: ${name.text}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Meaning: ${name.meaning}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
              child: Row(
                children: <Widget>[
                  // ignore: prefer_const_constructors
                  //Checkbox(value: value, onChanged: onChanged),
                  IconButton(
                      onPressed: () {
                        nameList.removeItem(name.text);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ),
            SizedBox(
              height: 400,
              width: 600,
              child: CarouselSlider.builder(
                carouselController: _controller,
                itemCount: images.length,
                options: CarouselOptions(
                    height: 385.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    //pageSnapping: false,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1400),
                    viewportFraction: 0.8,
                    pauseAutoPlayOnManualNavigate: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        //images = widget.name.getImgList();
                        activateIndex = index;
                      });
                    }),
                itemBuilder: (context, index, realIndex) {
                  final img = images[index];

                  return buildImage(img, index);
                },
              ),
            ),
            const SizedBox(height: 10),
            buildIndicator(images),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String img, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey,
      child: Image.file(
        File(img),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget buildIndicator(List<String> images) => AnimatedSmoothIndicator(
        activeIndex: activateIndex,
        count: images.length,
        effect: const SwapEffect(
          activeDotColor: Colors.blue,
          dotColor: Colors.black12,
          dotHeight: 10,
          dotWidth: 10,
        ),
        onDotClicked: animateToSlide,
      );

  void animateToSlide(int index) {
    // if (index > images.length) {
    //   index = 0;
    // }
    try {
      _controller.animateToPage(index);
    } catch (e) {
      print(e);
    }
  }

  // Future pause() async {
  //   int result = await _audio.pause();
  //   if (result == 1) {
  //     setState(() {
  //       _isPlaying = false;
  //     });
  //   }
  // }

  // Future resume() async {
  //   int result = await _audio.resume();
  //   if (result == 1) {
  //     setState(() {
  //       _isPlaying = true;
  //     });
  //   }
  // }
}
