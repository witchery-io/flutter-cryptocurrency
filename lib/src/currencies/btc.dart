import 'dart:collection';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/coin.dart';

class BTC implements Coin {
  bip32.BIP32 node;
  HDWallet root;
  IconData icon = FontAwesomeIcons.bitcoin;
  final name = 'btc';
  final isActive = true;
  final _coinType = "0'";
  final int account;
  final _change = '0';
  final String network;
  final SplayTreeMap<int, Address> _cacheAddresses = SplayTreeMap();

  BTC(this.node, {@required this.account, @required this.network}) {
    root = HDWallet.fromBase58(node.toBase58(),
            network: network == 'main' ? bitcoin : testnet)
        .derivePath("$_coinType/$account'/$_change");
  }

  @override
  Map<int, Address> generateAddresses(from, to) {
    assert(to > from);
    for (int i = from; i < to; i++) {
      _cacheAddresses.putIfAbsent(i, () {
        final HDWallet item = root.derivePath('$i');
        return BtcAddress(item.address, item.wif);
      });
    }

    return _cacheAddresses;
  }

  @override
  Future<List> addressList() => Future.value(_cacheAddresses.values.toList());

  @override
  Address getAddressByIndex(int index) =>
      _cacheAddresses.containsKey(index) ? _cacheAddresses[index] : null;

  @override
  transactionBuilder({fee, price, address, addressReceive, data}) {
    try {
      final _network = network == 'main' ? bitcoin : testnet;
      final txb = TransactionBuilder(network: _network);
      txb.setVersion(1);
      final List<Map<int, Map<int, Map<int, ECPair>>>> signData = [];

      for (int i = 0; i < data.length; i++) {
        final txBuildData = data[i];
        final balance = txBuildData.balance;
        final ownAddress = txBuildData.address;
        final ecPair = ECPair.fromWIF(txBuildData.privateKey);
        final List txs = txBuildData.txs;

        txs.asMap().forEach((txIndex, transaction) {
          final List outputs = transaction['outputs'];
          outputs.asMap().forEach((outputIndex, output) {
            if (output['addresses'].contains(ownAddress) &&
                output['spent_by'].length == 0) {
              txb.addInput(transaction['hash'], outputIndex);
              signData.add({
                i: {
                  txIndex: {outputIndex: ecPair}
                }
              });
            }
          });
        });

        if (price > 0 || fee > 0) {
          if (price > 0 && fee > 0 && balance >= (price + fee)) {
            final rcBls = balance - (price + fee);
            txb.addOutput(address, price);
            txb.addOutput(addressReceive, rcBls);
            price = 0;
            fee = 0;
          } else {
            if (balance > price) {
              if (price > 0) {
                txb.addOutput(address, price);
                price = 0;
              }

              final diff = balance - price;
              if (diff > fee) {
                txb.addOutput(addressReceive, diff - fee);
                fee = 0;
              } else {
                fee = fee - diff;
              }
            } else {
              txb.addOutput(address, balance);
              price = price - balance;
            }
          }
        } else {
          txb.addOutput(addressReceive, balance);
        }
      }

      signData.asMap().forEach((index, val) {
        val.forEach((_, val) {
          val.forEach((_, val) {
            val.forEach((_, ecPair) {
              txb.sign(index, ecPair);
            });
          });
        });
      });

      final build = txb.build();
      return build.toHex();
    } catch (e) {
      throw Exception(e);
    }
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
