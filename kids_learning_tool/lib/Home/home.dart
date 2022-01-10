import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Learning Tool for Special kids'),
          backgroundColor: Colors.amberAccent[800],
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 350,
            //color: Colors.grey[700],
            child: Card(
              color: Colors.grey[500],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 60),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/noun')
                            .then((value) => setState(() {}));
                      },
                      child: const Text('Noun',
                          style: TextStyle(
                            fontSize: 24,
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 60), elevation: 3),
                      onPressed: () {},
                      child: const Text(
                        'Verb',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 60), elevation: 3),
                      onPressed: () => {},
                      child: const Text(
                        'Task Scheduling',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 60), elevation: 3),
                      onPressed: () {},
                      child: const Text(
                        'Colour',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //SystemChannels.platform.invokeMethod('SystemNavigator.pop()');
            exit(0);
          },
          label: const Text('Exit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          icon: const Icon(Icons.close),
          //backgroundColor: Colors.pink,
        ));
  }
}
