import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart' as w3d;

import '../interfaces/coin.dart';
import '../resources/crypto_provider.dart';

class ETH implements Coin {
  bip32.BIP32 node;
  bip32.BIP32 hdWallet;
  CryptoProvider crypto;
  IconData icon = FontAwesomeIcons.ethereum;
  final name = 'eth';
  final _basePath = "60'/0'/0/0";

  ETH(this.crypto, this.node, {network = 'testnet'}) {
    hdWallet = node.derivePath("$_basePath");
  }

  @override
  String getPublicKey() {
    return '0x' + HEX.encode(hdWallet.publicKey);
  }

  @override
  String getPrivateKey() {
    return '0x' + HEX.encode(hdWallet.privateKey);
  }

  @override
  Future<String> getAddress() async {
    w3d.EthereumAddress address =
        await w3d.EthPrivateKey.fromHex(getPrivateKey()).extractAddress();
    return address.toString();
  }

  @override
  Future<void> transaction(address, price) {
    throw Exception('[ETH] Please try again letter');
  }
}
