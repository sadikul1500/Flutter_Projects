import 'package:flutter/material.dart';
import 'package:world_time/Pages/choose_location.dart';
import 'package:world_time/Pages/home.dart';
import 'package:world_time/Pages/loading.dart';

void main() {
  runApp(MaterialApp(
    //home: Home(),
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation()
    },
  ));
}
