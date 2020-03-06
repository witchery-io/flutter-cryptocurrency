import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/models.dart';

class EOS implements Coin {
  bip32.BIP32 node;
  bip32.BIP32 root;
  IconData icon = FontAwesomeIcons.coins;
  final name = 'eos';
  final _basePath = "194'/0'/0";
  final Map<int, Address> _cacheAddresses = {};

  EOS(this.node, {network = 'testnet'}) {
    root = node.derivePath("$_basePath");
  }

  @override
  Map<int, Address> generateAddresses({next}) {
    return _cacheAddresses;
  }

  @override
  Future<List> addressList() => Future.value(_cacheAddresses.values.toList());

  @override
  Address getAddressByIndex(int index) {
    return _cacheAddresses.containsKey(index) ? _cacheAddresses[index] : null;
  }

  @override
  Future transaction(String address, double price) {
    return null;
  }
}

class EosAddress implements Address {
  String _address;
  String _privateKey;

  EosAddress(this._address, this._privateKey);

  @override
  get address => _address;

  @override
  get privateKey => _privateKey;
}
