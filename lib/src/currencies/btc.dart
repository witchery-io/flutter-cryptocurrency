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
  final _basePath = "0'/0'/0";
  final String network;
  final Map<int, Address> _cacheAddresses = {};

  BTC(this.node, {this.network = 'testnet'}) {
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
  transactionBuilder({fee, price, address, addressReceive, data}) {
    try {
      final _network = network == 'testnet' ? testnet : bitcoin;
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

        if (price == 0 && fee == 0) {
          txb.addOutput(addressReceive, balance);
        } else if (price != 0 || fee != 0) {
          if (balance >= (price + fee)) {
            final rcBls = balance - (price + fee);
            txb.addOutput(address, price);
            txb.addOutput(addressReceive, rcBls);
            price = 0;
            fee = 0;
          } else if (balance >= price && price != 0) {
            txb.addOutput(address, price);
            price = 0;
            final diff = balance - price;
            if (diff > fee) {
              txb.addOutput(addressReceive, diff);
              fee = 0;
            } else {
              fee = fee - diff;
            }
          } else if (fee > 0 && price == 0) {
            if (balance > fee) {
              txb.addOutput(addressReceive, balance - fee);
              fee = 0;
            } else {
              fee = fee - balance;
            }
          } else {
            txb.addOutput(address, balance);
            price = price - balance;
          }
        } else {
          throw Exception('Invalid Transaction');
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
