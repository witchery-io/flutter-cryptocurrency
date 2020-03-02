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
  final Map<int, HDWallet> cacheAddresses = {};

  BTC(this.node, {network = 'testnet'}) {
    root = HDWallet.fromBase58(node.toBase58(),
            network: network == 'testnet' ? testnet : bitcoin)
        .derivePath(_basePath);
  }

  @override
  addresses({to}) {
    for (int i = 0; i < to; i++) {
      cacheAddresses[i] = root.derivePath('$i');
    }

    return cacheAddresses;
  }

  @override
  Future<void> transaction(address, price) {
    return null;
  }
}
