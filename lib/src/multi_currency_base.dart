import 'dart:convert';

import 'package:bip32/bip32.dart' as bip32;
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' show Client;

import '../multi_currency.dart';
import '../src/currencies/currencies.dart';
import '../src/interfaces/coin.dart';
import '../src/network.dart';
import '../src/resources/crypto_provider.dart';
import '../src/utils/mnemonic.dart';
import 'di/bloc_module.dart';
import 'utils/env.dart';

class MultiCurrency {
  Coin _coin;
  Mnemonic _mnemonic;
  bip32.BIP32 _node;
  CryptoProvider _crypto;

  MultiCurrency(String mnemonic) {
    _mnemonic = Mnemonic(mnemonic);
    if (!_mnemonic.isValid) throw Exception('Invalid mnemonic');

    _crypto = BlocModule().cryptoProvider(Client());

    _node = bip32.BIP32
        .fromSeed(
            _mnemonic.mnemonicToSeed, network == 'testnet' ? testNet : mainNet)
        .derivePath("m/44'");
  }

  Coin getCurrency(Currency type) {
    switch (type) {
      case Currency.BTC:
        _coin = Btc(_crypto, _node);
        break;
      case Currency.ETH:
        _coin = Eth(_crypto, _node);
        break;
      case Currency.EOS:
        _coin = Eos(_crypto, _node);
        break;
    }

    return _coin;
  }

  Future<String> md5Address(Currency cur) async {
    final address = await getCurrency(cur).getAddress();
    return md5.convert(utf8.encode(address)).toString();
  }
}
