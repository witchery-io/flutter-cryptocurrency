import 'package:flutter/material.dart';

abstract class Coin {
  String get name;

  bool get isActive;

  IconData icon;

  Map<int, Address> generateAddresses(from, to);

  transactionBuilder(
      {@required fee,
      @required price,
      @required address,
      @required addressReceive,
      @required data});

  Future<List> addressList();

  Address getAddressByIndex(int index);
}

abstract class Address {
  String get address;

  String get privateKey;
}
