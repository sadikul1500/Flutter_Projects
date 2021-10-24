import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyCard(),
  ));
}

class MyCard extends StatefulWidget {
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  double cgpa = 3.81;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text('ID Card'),
          centerTitle: true,
          backgroundColor: Colors.grey[600],
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              cgpa += .01;
            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey[700],
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/boss.jpg'),
                    radius: 60.0,
                  ),
                ),
                Center(
                    child: Text(
                  'Software Engineer',
                  style: TextStyle(
                    color: Colors.deepOrange[300],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                Divider(
                  color: Colors.grey[600],
                  height: 40.0,
                ),
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.grey[400],
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Mahdee Hasan',
                  style: TextStyle(
                    color: Colors.amber[400],
                    letterSpacing: 2.0,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Current CGPA',
                  style: TextStyle(
                    color: Colors.grey[400],
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  '$cgpa',
                  style: TextStyle(
                    color: Colors.amber[400],
                    letterSpacing: 2.0,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'bsse1010@iit.du.ac.bd',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.facebook,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'facebook.com/mahdeehasan',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}

// class Test extends StatefulWidget {
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
