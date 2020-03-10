import 'package:flutter/material.dart';

abstract class Coin {
  String get name;

  IconData icon;

  Map<int, Address> generateAddresses({@required int next});

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
