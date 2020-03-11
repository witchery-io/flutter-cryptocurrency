import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_currency/src/models/models.dart';

class BTC implements Coin {
  bip32.BIP32 node;
  HDWallet root;
  IconData icon = FontAwesomeIcons.bitcoin;
  final name = 'btc';
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
      int sendingPrice = price;
      int sendingFee = fee;
      final keys = {};

      for (int i = 0; i < data.length; i++) {
        final txBuildData = data[i];
        final balance = txBuildData.balance;
        final ecPair = ECPair.fromWIF(txBuildData.privateKey);
        keys[i] = ecPair;

        txBuildData.txs.asMap().forEach((index, tx) {
          tx['outputs'].asMap().forEach((index, output) {
            if (output['addresses'].contains(txBuildData.address) &&
                output['spent_by'].length == 0) {
              txb.addInput(tx['hash'], index);
            }
          });
        });

        if (sendingPrice > balance) {
          txb.addOutput(address, balance);
          sendingPrice = sendingPrice - balance;
        } else if (sendingPrice == 0 && sendingFee == 0) {
          txb.addOutput(addressReceive, balance);
        } else if (sendingFee != 0 && sendingPrice == 0) {
          if (sendingFee < balance) {
            txb.addOutput(addressReceive, balance - sendingFee);
            sendingFee = 0;
          }
        } else {
          txb.addOutput(address, sendingPrice);
          sendingPrice = 0;

          final backUpBalance = balance - sendingPrice;
          if (backUpBalance > sendingFee) {
            txb.addOutput(addressReceive, backUpBalance - sendingFee);
            sendingFee = 0;
          } else {
            sendingFee = sendingFee - backUpBalance;
          }
        }
      }

      txb.inputs.asMap().forEach((index, input) {
        txb.sign(index, keys[index]);
      });

      return txb.build().toHex();
    } catch (e) {
      print(e);
//      throw Exception(e);
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
