//import 'dart:convert';

import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
//import 'dart:io';

class NameList {
  late List<Name> names;

  NameList() {
    names = [
      Name('Umbrella', 'ছাতা', 'assets/nouns/Umbrella'),
      Name('Apple', 'আপেল', 'assets/nouns/Apple'),
      Name('Car', 'গাড়ি', 'assets/nouns/Car'),
      Name('Deer', 'হরিণ', 'assets/nouns/Deer'),
    ];
  }

  void add(String text, String meaning, String dir) {
    names.add(Name(text, meaning, dir));
  }

  List<Name> getList() {
    names.sort((a, b) => a.text.compareTo(b.text));
    return names;
  }
}
