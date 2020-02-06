import 'dart:convert';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' show Client;

import '../multi_currency.dart';
import 'currencies/currencies.dart';
import 'di/bloc_module.dart';
import 'interfaces/coin.dart';
import 'networks.dart';
import 'resources/crypto_provider.dart';

class MultiCurrency {
  CryptoProvider crypto;
  bip32.BIP32 node;
  Map<Currency, Coin> cache = {};
  String network;
  final derPath = "m/44'";

  MultiCurrency(String mn, {this.network = 'testnet'})
      : assert(mn != null),
        assert(network != null) {
    if (!bip39.validateMnemonic(mn)) throw Exception('Mnemonic is not valid.');

    crypto = BlocModule().cryptoProvider(Client());
    final seed = bip39.mnemonicToSeed(mn);
    node = bip32.BIP32
        .fromSeed(seed, network == 'testnet' ? testNet : mainNet)
        .derivePath(derPath);
  }

  Coin getCurrency(Currency type) {
    switch (type) {
      case Currency.BTC:
        if (!cache.containsKey(Currency.BTC))
          cache[Currency.BTC] = BTC(crypto, node, network: network);
        break;
      case Currency.ETH:
        if (!cache.containsKey(Currency.ETH))
          cache[Currency.ETH] = ETH(crypto, node, network: network);
        break;
      case Currency.EOS:
        if (!cache.containsKey(Currency.EOS))
          cache[Currency.EOS] = EOS(crypto, node, network: network);
        break;
    }

    if (!cache.containsKey(type)) throw Exception('Ups something is wrong.');

    return cache[type];
  }

  Future<String> md5Address(Currency cur) async {
    final address = await getCurrency(cur).getAddress();
    return md5.convert(utf8.encode(address)).toString();
  }
}
