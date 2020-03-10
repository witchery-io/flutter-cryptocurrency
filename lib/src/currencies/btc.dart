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
  Future transactionBuilder({fee, price, address, addressReceive, data}) {
    final _txb = TransactionBuilder(network: testnet);
    final intFee = fee.toInt();
    final intPrice = price.toInt();

    for (int i = 0; i < data.length; i++) {
      final txBuildData = data[i];
      final ecPair = ECPair.fromWIF(txBuildData.privateKey);

      try {
        txBuildData.txs.asMap().forEach((index, tx) {
          tx['outputs'].asMap().forEach((index, output) {
            if (output['addresses'].contains(txBuildData.address) &&
                output['spent_by'].length == 0) {
              _txb.addInput(tx['hash'], index);
            }
          });
        });

        print(' ---- INT FEE ---- ');
        print(intFee);

        print(' ---- SEND ADDRESS ---- ');
        print(address);
        print(intPrice);

        print(' ---- RECEIVE ADDRESS ---- ');
        print(addressReceive);

        print(' ---- BALANCE ---- ');
        print(txBuildData.balance);
        print('- -- --- ---- ----- A ');

//        _txb.addOutput(address, price.toInt());
//        _txb.addOutput(addressReceive, 20000);

        _txb.inputs.asMap().forEach((index, input) {
          _txb.sign(index, ecPair);
        });

        print(_txb.inputs);
        print(_txb.build().toHex());

      } catch (e) {
        print(e);
      }
    }

    return Future.value('____');
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
