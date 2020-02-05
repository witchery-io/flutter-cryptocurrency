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
  bip32.BIP32 node;
  CryptoProvider crypto;
  Map cache;

  MultiCurrency(String mn, {network = 'testnet'}) : assert(mn != null) {
    if (!bip39.validateMnemonic(mn)) throw Exception('Invalid mnemonic');

    crypto = BlocModule().cryptoProvider(Client());

    node = bip32.BIP32
        .fromSeed(
            bip39.mnemonicToSeed(mn), network == 'testnet' ? testNet : mainNet)
        .derivePath("m/44'");
  }

  Coin getCurrency(Currency type) {
    switch (type) {
      case Currency.BTC:
        final btc = Btc(crypto, node);
        // add cache
        return btc;
      case Currency.ETH:
        // add cache
        return Eth(crypto, node);
      case Currency.EOS:
        // add cache
        return Eos(crypto, node);
    }

    return null; // unknown case
  }

  Future<String> md5Address(Currency cur) async {
    final address = await getCurrency(cur).getAddress();
    return md5.convert(utf8.encode(address)).toString();
  }
}
