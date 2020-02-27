import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart' show Client;

import '../multi_currency.dart';
import 'currencies/currencies.dart';
import 'di/bloc_module.dart';
import 'models/models.dart';
import 'networks.dart';
import 'resources/crypto_provider.dart';

class MultiCurrency {
  final String mnemonic;
  CryptoProvider _provider;
  bip32.BIP32 _node;
  Map<Currency, Coin> _cache = {};
  final String network;
  final _derPath = "m/44'";

  MultiCurrency(this.mnemonic, {this.network = 'testnet'})
      : assert(mnemonic != null),
        assert(network != null) {
    if (!bip39.validateMnemonic(mnemonic)) throw Exception('Mnemonic is not valid.');

    _provider = BlocModule().cryptoProvider(Client());
    final seed = bip39.mnemonicToSeed(mnemonic);
    _node = bip32.BIP32
        .fromSeed(seed, network == 'testnet' ? testNet : mainNet)
        .derivePath(_derPath);
  }

  Coin _getCurrency(Currency type) {
    switch (type) {
      case Currency.BTC:
        if (!_cache.containsKey(Currency.BTC))
          _cache[Currency.BTC] = BTC(_provider, _node, network: network);
        break;
      case Currency.ETH:
        if (!_cache.containsKey(Currency.ETH))
          _cache[Currency.ETH] = ETH(_provider, _node, network: network);
        break;
      case Currency.EOS:
        if (!_cache.containsKey(Currency.EOS))
          _cache[Currency.EOS] = EOS(_provider, _node, network: network);
        break;
    }

    if (!_cache.containsKey(type)) throw Exception('Ups something is wrong.');

    return _cache[type];
  }

  Future<List<Coin>> get getCurrencies =>
      Future.value(Currency.values.map((curr) => _getCurrency(curr)).toList());
}
