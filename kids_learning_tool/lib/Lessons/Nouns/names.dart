import 'dart:async';
import 'dart:io';

class Name {
  String text;
  String meaning;
  String dir;
  List<String> imgList = [];

  Name(this.text, this.meaning, this.dir) {
    listDir(dir);
  }

  Future listDir(String folderPath) async {
    var directory = Directory(folderPath);
    //print(directory);

    var exists = await directory.exists();
    if (exists) {
      directory
          .list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) {
        String path = entity.path.replaceAll('\\', '/');
        imgList.add(path);
      });
    }
  }
}
