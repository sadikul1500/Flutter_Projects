import 'dart:async';
import 'dart:io';

class Name {
<<<<<<< HEAD
  late String text;
  late String meaning;
  late String dir;
  List<String> imgList = [];

  Name(this.text, this.meaning, this.dir) {
    listDir(dir).then((data) {
      imgList = data;
    });
  }

  List<String> getImgList() {
    return imgList;
=======
  String text;
  String meaning;
  String dir;
  List<String> imgList = [];

  Name(this.text, this.meaning, this.dir) {
    listDir(dir);
>>>>>>> 26fe921e79c117784b86eb4f49ca1d8111aa910f
  }

  Future listDir(String folderPath) async {
    var directory = Directory(folderPath);
    //print(directory);
<<<<<<< HEAD

    var exists = await directory.exists();
    if (exists) {
      directory
          .list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) {
        String path = entity.path.replaceAll('\\', '/');
        imgList.add(path);
      });
    }

    return imgList;
=======

    var exists = await directory.exists();
    if (exists) {
      directory
          .list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) {
        String path = entity.path.replaceAll('\\', '/');
        imgList.add(path);
      });
    }
>>>>>>> 26fe921e79c117784b86eb4f49ca1d8111aa910f
  }
}
