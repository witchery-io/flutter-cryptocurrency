import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/models.dart';

class BTC implements Coin {
  bip32.BIP32 node;
  HDWallet root;
  IconData icon = FontAwesomeIcons.bitcoin;
  final name = 'btc';
  final _basePath = "0'/0'/0";
  final Map<int, Address> cacheAddresses = {};

  BTC(this.node, {network = 'testnet'}) {
    root = HDWallet.fromBase58(node.toBase58(),
            network: network == 'testnet' ? testnet : bitcoin)
        .derivePath(_basePath);
  }

  @override
  Map<int, Address> generateAddresses({next}) {
    final from = cacheAddresses.length;
    final to = next + from;
    for (int i = from; i < to; i++) {
      final address = root.derivePath('$i');
      cacheAddresses[i] = BtcAddress(address.address, address.wif);
    }

    return cacheAddresses;
  }

  @override
  Future<void> transaction(address, price) {
    return null;
  }
}

class BtcAddress implements Address {
  String _address;
  String _privateKey;

  BtcAddress(this._address, this._privateKey);

  @override
  get address => _address;

  @override
  get privateKey => _privateKey;
}
