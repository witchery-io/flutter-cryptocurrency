import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/models.dart';

class ETH implements Coin {
  bip32.BIP32 node;
  bip32.BIP32 root;
  IconData icon = FontAwesomeIcons.ethereum;
  final name = 'eth';
  final _basePath = "60'/0'/0";
  final Map<int, Address> _cacheAddresses = {};

  ETH(this.node, {network = 'testnet'}) {
    root = node.derivePath("$_basePath");
  }

  @override
  Map<int, Address> generateAddresses({next}) {
    return _cacheAddresses;
  }

  @override
  Future<void> transaction(address, price) {
    throw Exception('Please try later');
  }

  @override
  List<Address> getAddress() {
    return _cacheAddresses.values.toList();
  }
}

class EthAddress implements Address {
  String _address;
  String _privateKey;

  EthAddress(this._address, this._privateKey);

  @override
  get address => _address;

  @override
  get privateKey => _privateKey;
}
