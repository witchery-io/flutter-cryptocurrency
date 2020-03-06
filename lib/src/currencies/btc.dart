import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/models.dart';
import 'package:multi_currency/src/utils/transaction_helper.dart';

class BTC implements Coin {
  bip32.BIP32 node;
  HDWallet root;
  IconData icon = FontAwesomeIcons.bitcoin;
  final name = 'btc';
  final _basePath = "0'/0'/0";
  final Map<int, Address> _cacheAddresses = {};

  BTC(this.node, {network = 'testnet'}) {
    root = HDWallet.fromBase58(node.toBase58(),
        network: network == 'testnet' ? testnet : bitcoin)
        .derivePath(_basePath);
  }

  @override
  Map<int, Address> generateAddresses({next}) {
    final from = _cacheAddresses.length;
    final to = next + from;
    assert(to > from);
    for (int i = from; i < to; i++) {
      final address = root.derivePath('$i');
      _cacheAddresses[i] = BtcAddress(address.address, address.wif);
    }

    return _cacheAddresses;
  }

  @override
  Future<List> addressList() => Future.value(_cacheAddresses.values.toList());

  @override
  Address getAddressByIndex(int index) {
    return _cacheAddresses.containsKey(index) ? _cacheAddresses[index] : null;
  }

  @override
  Future transactionBuilder() {

/*    const double fee = 0.001;
    final priceSat = price * 100000000;
    final feeSat = fee * 100000000;

    final outputs = [];
    balance.txs.asMap().forEach((index, tx) {
      tx.outputs.asMap().forEach((index, output) {
        if (output.addresses.contains(root.address) && output.spentBy.isEmpty) {
          outputs.add({'hash': tx.hash, 'index': index});
        }
      });
    });

    final transaction = TransactionHelper(
        senderAddress: root.address,
        balance: balance.balance.toInt(),
        address: address,
        price: priceSat.toInt(),
        ecPair: ECPair.fromWIF('private Key'), // todo getPrivateKey()
        outputs: outputs,
        fee: feeSat);

    return transaction.build();*/

    return Future.value(['ok bro!']);
  }
}

class BtcAddress implements Address {
  String _address;
  String _privateKey;

  BtcAddress(this._address, this._privateKey);

  @override
  get address => _address;

  @override
  get privateKey => _privateKey;
}
