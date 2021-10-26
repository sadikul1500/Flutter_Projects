import 'package:kids_learning_tool/Lessons/Nouns/names.dart';

class NameList {
  late List<Name> names;

  nameList() {
    names = [
      Name('Umbrella', 'ছাতা'),
      Name('Apple', 'আপেল'),
      Name('Car', 'গাড়ি'),
      Name('Deer', 'হরিণ'),
    ];
  }

  void add(String text, String meaning) {
    names.add(Name(text, meaning));
  }

  List<Name> getList() {
    names.sort((a, b) => a.text.compareTo(b.text));
    return names;
  }
}
