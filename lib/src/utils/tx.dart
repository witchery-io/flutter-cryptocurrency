import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter/foundation.dart';

class Tx {
  TransactionBuilder _txb;
  String senderAddress;
  int balance;
  String address;
  int price;
  ECPair ecPair;
  List outputs;
  double fee;
  String _txHex;

  get txHex => _txHex;

  Tx(
      {@required this.senderAddress,
      @required this.balance,
      @required this.address,
      @required this.price,
      @required this.ecPair,
      @required this.outputs,
      this.fee = 0.01,
      network = 'testnet'}) {
    _txb = TransactionBuilder(
      network: network == 'testnet' ? testnet : bitcoin,
    );
    _txb.setVersion(1);
  }

  build() {
    _setInputs();
    _setOutputs();
    _sign();
    _txHex = _txb.build().toHex();
  }

  _setInputs() {
    try {
      outputs.asMap().forEach((index, output) {
        _txb.addInput(output['hash'], output['index']);
      });
    } catch (e) {
      throw Exception('[Error TX - add Input] $e');
    }
  }

  _setOutputs() {
    try {
      _txb.addOutput(senderAddress, balance - (price + fee.toInt()));
      _txb.addOutput(address, price);
    } catch (e) {
      throw Exception('[Error TX - add Output] $e');
    }
  }

  _sign() {
    try {
      _txb.inputs.asMap().forEach((index, input) {
        _txb.sign(index, ecPair);
      });
    } catch (e) {
      throw Exception('[Error TX - sign] $e');
    }
  }
}
