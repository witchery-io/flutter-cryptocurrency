import 'dart:convert';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' show Client;

import '../multi_currency.dart';
import '../src/currencies/currencies.dart';
import '../src/interfaces/coin.dart';
import '../src/network.dart';
import '../src/resources/crypto_provider.dart';
import 'di/bloc_module.dart';

class MultiCurrency {
  bip32.BIP32 _node;
  CryptoProvider _crypto;

  MultiCurrency(String mn, {network = 'testnet'}) : assert(mn != null) {
    if (!bip39.validateMnemonic(mn)) throw Exception('Invalid mnemonic');

    _crypto = BlocModule().cryptoProvider(Client());

    _node = bip32.BIP32
        .fromSeed(
            bip39.mnemonicToSeed(mn), network == 'testnet' ? testNet : mainNet)
        .derivePath("m/44'");
  }

  Coin getCurrency(Currency type) {
    switch (type) {
      case Currency.BTC:
        return Btc(_crypto, _node);
      case Currency.ETH:
        return Eth(_crypto, _node);
      case Currency.EOS:
        return Eos(_crypto, _node);
    }

    return null; // unknown case
  }

  Future<String> md5Address(Currency cur) async {
    final address = await getCurrency(cur).getAddress();
    return md5.convert(utf8.encode(address)).toString();
  }
}
