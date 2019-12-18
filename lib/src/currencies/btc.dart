import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../resources/crypto_provider.dart';
import '../interfaces/coin.dart';
import '../utils/env.dart';
import '../utils/tx.dart';

class Btc implements Coin {
  bip32.BIP32 _node;

  HDWallet _hdWallet;

  CryptoProvider crypto;

  get name => 'btc';

  IconData icon = FontAwesomeIcons.bitcoin;

  final String _basePath = "0'/0'/0/0";

  Btc(this.crypto, bip32.BIP32 node) {
    _node = node;
    _hdWallet = HDWallet.fromBase58(
      _node.toBase58(),
      network: network == 'testnet' ? testnet : bitcoin,
    ).derivePath(_basePath);
  }

  @override
  String getPublicKey() {
    return _hdWallet.pubKey;
  }

  @override
  String getPrivateKey() {
    return _hdWallet.wif;
  }

  @override
  Future<String> getAddress() async {
    return _hdWallet.address;
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
    final balance = await crypto.getBalance(currency, _hdWallet.address);
    final priceSat = price * 100000000;
    final feeSat = fee * 100000000;

    if (balance.balance < (priceSat + feeSat)) {
      throw Exception('Insufficient balance');
    }

    final outputs = [];
    balance.txs.asMap().forEach((index, tx) {
      tx.outputs.asMap().forEach((index, output) {
        if (output.addresses.contains(_hdWallet.address) &&
            output.spentBy.isEmpty) {
          outputs.add({'hash': tx.hash, 'index': index});
        }
      });
    });

    final tx = Tx(
      senderAddress: _hdWallet.address,
      balance: balance.balance.toInt(),
      address: address,
      price: priceSat.toInt(),
      ecPair: _ecPair,
      outputs: outputs,
      fee: feeSat,
    );

    tx.build();
    print(tx.txHex);
//    await crypto.pushTx(currency, tx.txHex);
  }
}
