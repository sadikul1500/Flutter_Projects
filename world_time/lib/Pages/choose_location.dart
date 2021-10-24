import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;

  Widget build(BuildContext context) {
    print('build called');
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text('Choose location'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ElevatedButton(
          child: Text('Counter is $counter'),
          onPressed: () {
            setState(() {
              counter += 1;
            });
          },
        ) //SafeArea(child: Text('Choose Location Screen')),
        );
  }
}
