import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/coin.dart';
import '../resources/crypto_provider.dart';

class EOS implements Coin {
  bip32.BIP32 node;
  bip32.BIP32 root;
  CryptoProvider crypto;
  IconData icon = FontAwesomeIcons.coins;
  final name = 'eos';
  final _basePath = "194'/0'/0";
  final Map<int, bip32.BIP32> cacheAddresses = {};

  EOS(this.crypto, this.node, {network = 'testnet'}) {
    root = node.derivePath("$_basePath");
  }

  @override
  addresses({to}) {
    return cacheAddresses;
  }

  @override
  Future<void> transaction(address, price) {
    throw Exception('Please try later');
  }
}
