import 'package:flutter/material.dart';

abstract class Coin {
  String get name;
  IconData icon;
  addresses({@required int next});
  Future<void> transaction(String address, double price);
}
