import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NameList {
  List<Name> names = [];
  File file =
      File('D:/Sadi/FlutterProjects/kids_learning_tool/nounList/noun.txt');
  List<String> lines = [];

  NameList() {
    //await Future.delayed(const Duration(milliseconds: 500));
    loadData().then((data) {
      createNames();
    });
    //createNames();

    // names = [
    //   Name('Umbrella', 'ছাতা', 'assets/nouns/Umbrella'),
    //   Name('Apple', 'আপেল', 'assets/nouns/Apple'),
    //   Name('Car', 'গাড়ি', 'assets/nouns/Car'),
    //   Name('Deer', 'হরিণ', 'assets/nouns/Deer'),
    // ];
  }

  Future loadData() async {
    //await Future.delayed(const Duration(milliseconds: 500));
    await _read();
  }

  void createNames() {
    for (String line in lines) {
      final ln = line.split('; ');
      names.add(Name(ln[0], ln[1], ln[2]));
    }
    // print(100);
    // print(lines);
    // print(120);
    // print(names);
  }

  void addNoun(String text, String meaning, String dir) {
    names.add(Name(text, meaning, dir));
  }

  List<Name> getList() {
    if (names.isEmpty) {
      loadData();
    }
    names.sort((a, b) => a.text.compareTo(b.text));
    return names;
  }

  //write read write operations
  Future<File> _write(String text, String meaning, String dir) async {
    // final file = await File(
    //     'D:/Sadi/FlutterProjects/kids_learning_tool/nounList/noun.txt');

    // Write the file
    String line = text + '; ' + meaning + '; ' + dir;
    addNoun(text, meaning, dir);
    return file.writeAsString(line, mode: FileMode.append);
  }

  Future _read() async {
    //List<String> textLines = [];
    try {
      //final Directory directory = await getApplicationDocumentsDirectory();
      //final File file = File('${directory.path}/my_file.txt');
      lines = await file.readAsLines();
    } catch (e) {
      print("Couldn't read file");
    }
    //return textLines;
  }
}
