import 'package:flutter/material.dart';

abstract class Coin {
  String get name;
  IconData icon;
  List get cacheAddresses;
  List addresses({@required start, @required end});
}
