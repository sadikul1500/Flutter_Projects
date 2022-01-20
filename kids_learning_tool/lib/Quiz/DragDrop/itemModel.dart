import 'package:flutter/cupertino.dart';

class ItemModel {
  String name;
  String value;
  IconData icon;
  bool accepting;

  ItemModel(this.name, this.value, this.icon, {this.accepting = false});
}
