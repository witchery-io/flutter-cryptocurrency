import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../interfaces/coin.dart';
import '../resources/crypto_provider.dart';
import '../utils/tx.dart';

class BTC implements Coin {
  bip32.BIP32 node;
  HDWallet hdWallet;
  CryptoProvider crypto;
  IconData icon = FontAwesomeIcons.bitcoin;
  final name = 'btc';
  final _basePath = "0'/0'/0/0";

  BTC(this.crypto, this.node, {network = 'testnet'}) {
    hdWallet = HDWallet.fromBase58(node.toBase58(),
            network: network == 'testnet' ? testnet : bitcoin)
        .derivePath(_basePath);
  }

  @override
  String getPublicKey() {
    return hdWallet.pubKey;
  }

  @override
  String getPrivateKey() {
    return hdWallet.wif;
  }

  @override
  Future<String> getAddress() async {
    return hdWallet.address;
  }

  ECPair get _ecPair {
    return ECPair.fromWIF(getPrivateKey());
  }

  @override
  Future transaction(address, price) async {
    if (address.isEmpty) {
      throw ArgumentError('Empty address');
    }

    if (price.isNegative) {
      throw ArgumentError('Negative price');
    }

    const currency = 'btc';
    const double fee = 0.001; /* fee */
    final balance = await crypto.getBalance(currency, hdWallet.address);
    final priceSat = price * 100000000;
    final feeSat = fee * 100000000;

    if (balance.balance < (priceSat + feeSat)) {
      throw Exception('Insufficient balance');
    }

    final outputs = [];
    balance.txs.asMap().forEach((index, tx) {
      tx.outputs.asMap().forEach((index, output) {
        if (output.addresses.contains(hdWallet.address) &&
            output.spentBy.isEmpty) {
          outputs.add({'hash': tx.hash, 'index': index});
        }
      });
    });

    final tx = Tx(
        senderAddress: hdWallet.address,
        balance: balance.balance.toInt(),
        address: address,
        price: priceSat.toInt(),
        ecPair: _ecPair,
        outputs: outputs,
        fee: feeSat);

    tx.build();
    await crypto.pushTx(currency, tx.txHex);
  }
}
