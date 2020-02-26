import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../interfaces/coin.dart';
import '../resources/crypto_provider.dart';

class EOS implements Coin {
  bip32.BIP32 node;
  bip32.BIP32 root;
  CryptoProvider crypto;
  IconData icon = FontAwesomeIcons.coins;
  final name = 'eos';
  final _basePath = "194'/0'/0";
  final List<bip32.BIP32> cacheAddresses = [];

  EOS(this.crypto, this.node, {network = 'testnet'}) {
    root = node.derivePath("$_basePath");
  }

  @override
  Future addresses({start, end}) {
    if (start > end) throw ArgumentError('Argument is not valid');

    return Future.value(cacheAddresses);
  }
}
