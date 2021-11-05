import 'package:kids_learning_tool/Lessons/Nouns/names.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NameList {
  List<Name> names = [];
  File file =
      File('D:/Sadi/FlutterProjects/kids_learning_tool/nounList/noun.txt');
  List<String> lines = [];

  NameList() {
    loadData();
  }

  Future loadData() async {
    await _read();
    createNames();
  }

  void createNames() {
    for (String line in lines) {
      final ln = line.split('; ');
      names.add(Name(ln[0], ln[1], ln[2], ln[3]));
    }
  }

  Future addNoun(String text, String meaning, String dir, String audio) async {
    names.add(Name(text, meaning, dir, audio));
    await _write(text, meaning, dir, audio);
  }

  List<Name> getList() {
    if (names.isEmpty) {
      loadData();
    }
    names.sort((a, b) => a.text.compareTo(b.text));
    return names;
  }

  //write read write operations
  Future<File> _write(
      String text, String meaning, String dir, String audio) async {
    // final file = await File(
    //     'D:/Sadi/FlutterProjects/kids_learning_tool/nounList/noun.txt');

    // Write the file
    String line = text + '; ' + meaning + '; ' + dir + '; ' + audio;
    //addNoun(text, meaning, dir);
    return file.writeAsString('\n$line', mode: FileMode.append);
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
