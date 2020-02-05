import 'package:bip32/bip32.dart' as bip32;
import 'package:eosdart/eosdart.dart' as eos_io;
import 'package:eosdart_ecc/eosdart_ecc.dart' as eos_ecc;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../interfaces/coin.dart';
import '../resources/crypto_provider.dart';

class Eos implements Coin {
  bip32.BIP32 _node;
  bip32.BIP32 _hdWallet;
  CryptoProvider crypto;
  String name = 'eos';
  IconData icon = FontAwesomeIcons.coins;
  final String _basePath = "194'/0'/0/0";

  Eos(this.crypto, bip32.BIP32 node) {
    _node = node;
    _hdWallet = _node.derivePath("$_basePath");
  }

  @override
  String getPublicKey() {
    return eos_ecc.EOSPrivateKey.fromBuffer(_hdWallet.privateKey)
        .toEOSPublicKey()
        .toString();
  }

  @override
  String getPrivateKey() {
    return eos_ecc.EOSPrivateKey.fromBuffer(_hdWallet.privateKey).toString();
  }

  @override
  Future<String> getAddress() async {
    eos_io.EOSClient client =
        eos_io.EOSClient('https://api.jungle.alohaeos.com', 'v1');
    final data = await client.getKeyAccounts(getPublicKey());
    if (data.accountNames.isEmpty) {
      throw Exception('[EOS] Please register account');
    }

    return data.accountNames[0];
  }

  @override
  Future<void> transaction(address, price) {
    throw Exception('[EOS] Please try again letter');
  }
}
