//input form
// ignore_for_file: use_function_type_syntax_for_parameters

import 'dart:async';
import 'dart:io';
//import 'dart:ui';

//import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DragForm extends StatelessWidget {
  static const String _title = 'Quiz: Drag & Drop';

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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => DragFormState();
}

class DragFormState extends State<MyStatefulWidget> {
  static List<String> friendsList = [];
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  String _selectedFile = '';
  List<File> files = [];
  List<String> values = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          //trigger leaving and use own data
          Navigator.pop(context);
          //we need to return a future
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // name textfield
                  const Text(
                    'Add Draggable Objects',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Row(children: <Widget>[
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
                      const SizedBox(width: 5),
                      Text(_selectedFile), //files.last.path.split('\\').last
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        height: 25,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              hintText: 'Enter value to match'),
                          validator: (v) {
                            if (v!.trim().isEmpty) {
                              return 'Please enter something';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      _addRemoveButton(true, 0),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ..._getFriends(),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text('Submit'),
                    //color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: Text(friendsList[i])), //FriendTextFields(i)
            const SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(false, i), //
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          values.add(_nameController.text.trim());
          friendsList.add(
              files.last.path.split('\\').last + ' ; ' + values.last); //0, ''

          print(values.last);
          print(friendsList.last);
          setState(() {
            _selectedFile = '';
            _nameController.clear();
          });
        } else {
          friendsList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  void popup(String title, String content) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: title,
          contentText: content,
          onPositiveClick: () {
            Navigator.of(context).pop();
          },
          onNegativeClick: () {
            Navigator.of(context).pop();
          },
        );
      },
      animationType: DialogTransitionType.rotate3D,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp'],
    );

    if (result != null) {
      files.add(File((result.files.single.path)!));
      setState(() {
        _selectedFile = files.last.path.split('\\').last;
      });
    } else {
      // User canceled the picker
    }
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController.text = DragFormState.friendsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => DragFormState.friendsList[widget.index] = v,
      decoration: const InputDecoration(hintText: 'Enter your friend\'s name'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

