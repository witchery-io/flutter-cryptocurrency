import 'package:flutter/material.dart';

abstract class Coin {
  String get name;
  IconData icon;
  addresses({@required int to});
  Future<void> transaction(String address, double price);
}
