import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NounCard extends StatefulWidget {
  final Name name;
  NounCard({required this.name});

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
    activateIndex = 0;
    index = 0;
    super.initState();
  }

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
                itemCount: widget.name.getImgList().length,
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 1400),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) =>
                      setState(() => activateIndex = index),
                ),
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
      child: Image.asset(
        img,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activateIndex % images.length,
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
