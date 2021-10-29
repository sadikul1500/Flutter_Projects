import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Home/home.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_form.dart';
//import 'package:kids_learning_tool/Lessons/Nouns/noun_search_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      // '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/noun': (context) => Noun(),
      '/nounForm': (context) => NounForm(),
    },
  ));
}
