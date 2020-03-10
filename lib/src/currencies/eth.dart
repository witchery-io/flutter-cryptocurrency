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
  final String network;
  final Map<int, Address> _cacheAddresses = {};

  ETH(this.node, {this.network = 'testnet'}) {
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
  Future transactionBuilder({fee, price, address, addressReceive, data}) {
    return null;
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
