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
  final List<HDWallet> cacheAddresses = [];

  BTC(this.crypto, this.node, {network = 'testnet'}) {
    root = HDWallet.fromBase58(node.toBase58(),
            network: network == 'testnet' ? testnet : bitcoin)
        .derivePath(_basePath);
  }

  @override
  addresses({start = 0, end = 20}) {
    assert(start < end);
    for (int i = start; i < end; i++) cacheAddresses.add(root.derivePath('$i'));

    return cacheAddresses;
  }

  @override
  Future<void> transaction(address, price) {
    return null;
  }
}
