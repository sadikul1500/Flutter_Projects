import 'package:flutter/cupertino.dart';

class ItemModel {
  final String name;
  final String value;
  final IconData icon;
  bool accepting;

  ItemModel(this.name, this.value, this.icon, {this.accepting = false});
}
