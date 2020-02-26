import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../interfaces/coin.dart';
import '../resources/crypto_provider.dart';

class BTC implements Coin {
  bip32.BIP32 node;
  HDWallet root;
  CryptoProvider crypto;
  IconData icon = FontAwesomeIcons.bitcoin;
  final name = 'btc';
  final _basePath = "0'/0'/0";

  final _cacheAddresses = [];

  List get addressesList => _cacheAddresses;

  BTC(this.crypto, this.node, {network = 'testnet'}) {
    root = HDWallet.fromBase58(node.toBase58(),
            network: network == 'testnet' ? testnet : bitcoin)
        .derivePath(_basePath);
  }

  @override
  Future addresses({start, end}) async {
    if (start > end) throw ArgumentError('Argument is not valid');

    for (int i = start; i < end; i++) {
      _cacheAddresses.add(root.derivePath('$i'));
    }

    return Future.value(_cacheAddresses);
  }
}
