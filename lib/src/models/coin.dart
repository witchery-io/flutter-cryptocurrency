import 'package:flutter/material.dart';

abstract class Coin {
  String get name;

  IconData icon;

  Map<int, Address> generateAddresses({@required int next});

  Future<void> transaction(String address, double price);
}

abstract class Address {
  String get address;

  String get privateKey;
}
