/// Flutter code sample for Form

// This example shows a [Form] with one [TextFormField] to enter an email
// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Lessons/Nouns/name_list.dart';
import 'package:kids_learning_tool/Quiz/Matching/preview.dart';
import 'package:kids_learning_tool/Quiz/Matching/question.dart';

//void main() => runApp(const MyApp());

/// This is the main application widget.
class Matching extends StatelessWidget {
  //const NounForm({Key? key}) : super(key: key);

  static const String _title = 'Prepare a question';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        centerTitle: true,
      ),
      body: const MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedFiles = '';
  String _audioFile = '';
  String dropdownCategory = 'Noun';
  String dropdownAnswer = 'A';
  String question = 'What do you see in the picture?';
  late Question ques;
  TextEditingController noun = TextEditingController();
  TextEditingController meaning = TextEditingController();
  TextEditingController optionA = TextEditingController();
  TextEditingController optionB = TextEditingController();
  TextEditingController optionC = TextEditingController();
  TextEditingController optionD = TextEditingController();

  List<File> files = [];
  late File audio;
  String path = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');

        //trigger leaving and use own data
        Navigator.pop(context);
        //Navigator.pop(context);
        //Navigator.pushNamed(context, '/noun');

        //we need to return a future
        return Future.value(false);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(250, 40, 250, 20),
        color: Colors.white.withOpacity(0.80),
        child: Align(
          alignment: const Alignment(0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  const Text("Select Category",
                      style: TextStyle(color: Colors.blue, fontSize: 18)),
                  const SizedBox(width: 15),
                  DropdownButton(
                    hint: const Text("Select Category"),
                    //isExpanded: true,

                    items: ['Noun', 'Verb', 'Task Scheduling', 'Colour']
                        .map((option) {
                      return DropdownMenuItem(
                        child: Text(option),
                        value: option,
                      );
                    }).toList(),
                    value: dropdownCategory, //asign the selected value
                    onChanged: (String? value) {
                      setState(() {
                        dropdownCategory =
                            value!; //on selection, selectedDropDownValue i sUpdated
                      });
                    },
                  ),
                ]),
                const SizedBox(height: 10),
                OutlinedButton(
                    onPressed: () {
                      _openFileExplorer();
                    },
                    child: const Text(
                      'Select an Image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                Text(_selectedFiles),
                const SizedBox(height: 10),
                TextFormField(
                  controller: noun,
                  decoration: const InputDecoration(
                    hintText: 'What do you see in the picture?',
                    labelText: 'Question',
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'AvenirLight'),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                  ),
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: optionA,
                        decoration: const InputDecoration(
                          hintText: 'Option A',
                          labelText: 'Option A',
                          labelStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(width: 40), //SizedBox(height: 10),
                    Flexible(
                      child: TextFormField(
                        controller: optionB,
                        decoration: const InputDecoration(
                          hintText: 'Option B',
                          labelText: 'Option B',
                          labelStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: optionC,
                        decoration: const InputDecoration(
                          hintText: 'Option C',
                          labelText: 'Option C',
                          labelStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(width: 40), //SizedBox(height: 10),
                    Flexible(
                      child: TextFormField(
                        controller: optionD,
                        decoration: const InputDecoration(
                          hintText: 'Option D',
                          labelText: 'Option D',
                          labelStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: <Widget>[
                  const Text("Correct Answer ",
                      style: TextStyle(color: Colors.blue, fontSize: 18)),
                  const SizedBox(width: 10),
                  DropdownButton(
                    //hint: const Text("Select Category"),
                    //isExpanded: true,

                    items: ['A', 'B', 'C', 'D'].map((option) {
                      return DropdownMenuItem(
                        child: Text(option),
                        value: option,
                      );
                    }).toList(),
                    value: dropdownAnswer, //asign the selected value
                    onChanged: (String? value) {
                      setState(() {
                        dropdownAnswer =
                            value!; //on selection, selectedDropDownValue i sUpdated
                      });
                    },
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text(
                        'Preview',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50), elevation: 3),
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          createQuestion();
                          Navigator.of(context).push(
                            // With MaterialPageRoute, you can pass data between pages,
                            // but if you have a more complex app, you will quickly get lost.
                            MaterialPageRoute(
                              builder: (context) => Preview(ques),
                            ),
                          );
                          // Process data.
                          // saveImage();
                          // //saveAudio();
                          // createNoun(
                          //     path,
                          //     audio
                          //         .path); //'$path/${audio.path.split('\\').last}'
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) =>
                          //       _buildPopupDialog(context),
                          // );
                          //Navigator.pushNamed(context, '/home');
                        }
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50), elevation: 3),
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                          // saveImage();
                          // //saveAudio();
                          //createNoun(
                          //     path,
                          //     audio
                          //         .path); //'$path/${audio.path.split('\\').last}'
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) =>
                          //       _buildPopupDialog(context),
                          // );
                          //Navigator.pushNamed(context, '/home');
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp'],
    );

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      //PlatformFile file = result.files.first;

      setState(() {
        for (File file in files) {
          //print(file.path.split('/').last);
          _selectedFiles += file.path.split('\\').last + ', ';
        }
      });
    } else {
      // User canceled the picker
    }
  }

  Future saveImage() async {
    path =
        'D:/Sadi/FlutterProjects/kids_learning_tool/assets/nouns/${noun.text}';
    final newDir = await Directory(path).create(recursive: true);

    for (File file in files) {
      await file.copy('${newDir.path}/${file.path.split('\\').last}');
    }

    //createNoun(imagePath);
  }

  // Future saveAudio() async {
  //   // final audioPath =
  //   //     'D:/Sadi/FlutterProjects/kids_learning_tool/assets/nouns/${noun.text}';
  //   //final newDir = await Directory(imagePath).create(recursive: true);
  //   await audio.copy('$path/${audio.path.split('\\').last}');
  // }

  void createNoun(String dir, String audio) {
    NameList nameList = NameList();
    nameList.addNoun(noun.text, meaning.text, dir, audio);
  }

  void createQuestion() {
    List<String> options = [
      optionA.text,
      optionB.text,
      optionC.text,
      optionD.text
    ];
    ques = Question(
        dropdownCategory, files[0].path, question, options, dropdownAnswer);
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Info'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Saved Successfully"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              noun.clear();
              meaning.clear();
              _selectedFiles = '';
            });
            Navigator.of(context).pop();
          },
          //color: Theme.of(context).primaryColor,
          child: const Text('Ok'),
        ),
      ],
    );
  }
}

// OutlinedButton(
//     onPressed: () {
//       _openFileExplorer();
//     },
//     child: const Text(
//       'Select Images',
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w400,
//       ),
//     )),
// Text(_selectedFiles),
// const SizedBox(height: 10),
// OutlinedButton(
//     onPressed: () {
//       _selectAudio();
//     },
//     child: const Text(
//       'Select Audio',
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w400,
//       ),
//     )),
// Text(_audioFile),
// Center(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 16.0),
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           minimumSize: const Size(100, 50), elevation: 3),
//       onPressed: () {
//         // Validate will return true if the form is valid, or false if
//         // the form is invalid.
//         if (_formKey.currentState!.validate()) {
//           // Process data.
//           saveImage();
//           saveAudio();
//           createNoun(
//               path, '$path/${audio.path.split('\\').last}');
//           showDialog(
//             context: context,
//             builder: (BuildContext context) =>
//                 _buildPopupDialog(context),
//           );
//           //Navigator.pushNamed(context, '/home');
//         }
//       },
//       child: const Text(
//         'Submit',
//         style: TextStyle(
//           fontSize: 20,
//         ),
//       ),
//     ),
//   ),
// ),

//print(100);
//print(newDir);
//print(newDir.path);
//print('${newDir.path}/${file.path.split('\\').last}');
//print(300);
//print('$newDir/${file.path.split('\\').last}');

// print(file.bytes);
// print(file.size);
// print(file.extension);
// print(file.path);
