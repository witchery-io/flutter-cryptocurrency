import 'package:flutter/material.dart';

abstract class Coin {
  String get name;
  IconData icon;
  Future addresses({@required start, @required end});
}
