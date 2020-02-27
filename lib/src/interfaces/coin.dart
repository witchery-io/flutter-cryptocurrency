import 'package:flutter/material.dart';

abstract class Coin {
  String get name;
  IconData icon;
  List addresses({@required start, @required end});
}
