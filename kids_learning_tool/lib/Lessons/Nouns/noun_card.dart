import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/names.dart';

class NounCard extends StatelessWidget {
  final Name name;
  NounCard({required this.name});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 15.0),
            Text(
              'Meaning: ${name.meaning}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
