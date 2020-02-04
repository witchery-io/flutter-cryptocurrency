import 'package:bip32/bip32.dart' as BIP32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart' as W3D;

import '../interfaces/coin.dart';
import '../resources/crypto_provider.dart';

class Eth implements Coin {
  BIP32.BIP32 _node;
  BIP32.BIP32 _hdWallet;

  CryptoProvider crypto;

  get name => 'eth';

  IconData icon = FontAwesomeIcons.ethereum;

  final String _basePath = "60'/0'/0/0";

  Eth(this.crypto, BIP32.BIP32 node) {
    _node = node;
    _hdWallet = _node.derivePath("$_basePath");
  }

  @override
  String getPublicKey() {
    return '0x' + HEX.encode(_hdWallet.publicKey);
  }

  @override
  String getPrivateKey() {
    return '0x' + HEX.encode(_hdWallet.privateKey);
  }

  @override
  Future<String> getAddress() async {
    W3D.EthereumAddress address =
        await W3D.EthPrivateKey.fromHex(getPrivateKey()).extractAddress();
    return address.toString();
  }

  @override
  Future<void> transaction(address, price) {
    throw Exception('[ETH] Please try again letter');
  }
}
