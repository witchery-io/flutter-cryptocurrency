import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/coin.dart';

class EOS implements Coin {
  bip32.BIP32 node;
  bip32.BIP32 root;
  IconData icon = FontAwesomeIcons.coins;
  final name = 'eos';
  final isActive = false;
  final _coinType = "194'";
  final int account;
  final _change = '0';
  final String network;
  final Map<int, Address> _cacheAddresses = {};

  EOS(this.node, {@required this.account, @required this.network}) {
    root = node.derivePath("$_coinType/$account'/$_change");
  }

  @override
  Map<int, Address> generateAddresses(from, to) {
    assert(to > from);
    return _cacheAddresses;
  }

  @override
  Future<List> addressList() => Future.value(_cacheAddresses.values.toList());

  @override
  Address getAddressByIndex(int index) =>
      _cacheAddresses.containsKey(index) ? _cacheAddresses[index] : null;

  @override
  transactionBuilder({fee, price, address, addressReceive, data}) => null;
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
