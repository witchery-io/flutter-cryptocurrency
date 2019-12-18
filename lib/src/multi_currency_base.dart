import 'package:http/http.dart' show Client;
import 'package:bip32/bip32.dart' as BIP32;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../src/resources/crypto_provider.dart';
import '../src/interfaces/coin.dart';
import '../src/currencies/btc.dart';
import '../src/currencies/eos.dart';
import '../src/currencies/eth.dart';
import '../multi_currency.dart';
import '../src/utils/mnemonic.dart';
import '../src/network.dart';
import 'di/bloc_module.dart';
import 'utils/env.dart';

class MultiCurrency {
  Coin _coin;
  Mnemonic _mnemonic;
  BIP32.BIP32 _node;
  CryptoProvider _crypto;

  /*
  * modify
  * */
  Future<String> get btcMD5Address async {
    final btcAddress = await getCurrency(Currency.BTC).getAddress();
    return md5.convert(utf8.encode(btcAddress)).toString();
  }

  MultiCurrency(String mnemonic) {
    _crypto = BlocModule().cryptoProvider(Client());
    _mnemonic = Mnemonic(mnemonic);
    if (!_mnemonic.isValid) {
      throw Exception('Invalid mnemonic');
    }

    _node = BIP32.BIP32
        .fromSeed(
          _mnemonic.mnemonicToSeed,
          network == 'testnet' ? testNet : mainNet,
        )
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
}
