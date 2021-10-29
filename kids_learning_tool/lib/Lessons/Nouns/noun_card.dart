import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NounCard extends StatefulWidget {
  final Name name;
  NounCard({required this.name});

  @override
  State<NounCard> createState() => _NounCardState();
}

class _NounCardState extends State<NounCard> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 15.0),
            Text(
              'Meaning: ${widget.name.meaning}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 400,
              width: 600,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 385.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 900),
                  viewportFraction: 0.8,
                ),
                items: widget.name.getImgList().map((item) {
                  //print('');
                  setState(() {});
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 250,
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 3,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
