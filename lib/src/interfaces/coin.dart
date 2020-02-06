import 'package:flutter/material.dart';

abstract class Coin {
  String get name;
  IconData icon;
  String getPublicKey();
  String getPrivateKey();
  Future<String> getAddress();
  Future<void> transaction(String address, double price);
}
