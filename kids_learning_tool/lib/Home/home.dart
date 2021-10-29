import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Tool for Special kids'),
        backgroundColor: Colors.amberAccent[800],
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 300,
          //color: Colors.grey[700],
          child: Card(
            color: Colors.grey[500],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/noun');
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
