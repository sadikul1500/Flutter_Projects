import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NounCard extends StatefulWidget {
  final Name name;
  final int ind;
  NounCard(this.name, this.ind);

  @override
  State<NounCard> createState() => _NounCardState();
}

class _NounCardState extends State<NounCard> {
  int index = 0;
  int activateIndex = 0;
  late List<String> images;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    activateIndex = widget.ind;
    // print('hehehehehehe');
    // print(activateIndex);

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   print('kaj korsi mama');
  //   activateIndex = widget.ind;
  //   //images = widget.name.getImgList();
  //   print('activate index dekho...');
  //   print(activateIndex);
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    images = widget.name.getImgList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Noun: ${widget.name.text}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Meaning: ${widget.name.meaning}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
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
            buildIndicator(),
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
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
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
}
