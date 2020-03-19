import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/cupertino.dart';

import '../multi_currency.dart';
import 'currencies/currencies.dart';
import 'models/coin.dart';
import 'networks.dart';

class MultiCurrency {
  final String mnemonic;
  bip32.BIP32 _node;
  Map<String, Coin> _cache = {};
  final String network;
  final _derPath = "m/44'";

  MultiCurrency(this.mnemonic, {@required this.network})
      : assert(mnemonic != null) {
    if (!bip39.validateMnemonic(mnemonic))
      throw Exception('Mnemonic is not valid');

    final seed = bip39.mnemonicToSeed(mnemonic);
    _node = bip32.BIP32
        .fromSeed(seed, network == 'main' ? mainNet : testNet)
        .derivePath(_derPath);
  }

  Future<List<Coin>> currenciesByAccount(int account) =>
      Future.value(Currency.values
          .map((curr) => _currency(type: curr, account: account))
          .toList());

  Coin _currency({@required int account, @required Currency type}) {
    _cache.putIfAbsent("$account:${type.index}", () {
      switch (type) {
        case Currency.BTC:
          return BTC(_node, account: account, network: network);
        case Currency.ETH:
          return ETH(_node, account: account, network: network);
        case Currency.EOS:
          return EOS(_node, account: account, network: network);
        default:
          return null;
      }
    });

    print(_cache);
    
    return _cache["$account:${type.index}"];
  }
}
