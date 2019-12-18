import 'package:multi_currency/multi_currency.dart';
import 'package:multi_currency/src/utils/mnemonic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('[Mnemonic] methods', () {
    final Mnemonic mnemonic = Mnemonic('soup animal leader blast feed need saddle rifle unit stumble stock pulp');
    expect(mnemonic.toString(), 'soup animal leader blast feed need saddle rifle unit stumble stock pulp');
    expect(mnemonic.isValid, true);
    expect(mnemonic.mnemonicToEntropy, 'cfe121fa0bb54b27af75cdedbaf75856');
    expect(mnemonic.mnemonicToSeedHex, '6e7af5fb53c9668c4c9eb5d86d6641c2e7cb0c0e4778656ad39c7151aec0b9f3ec181ac93f4a500e496fe0f8164aca3809a1cf408353dc773646b533e8f01d6f');
    expect(mnemonic.mnemonicToSeed, [
      110,
      122,
      245,
      251,
      83,
      201,
      102,
      140,
      76,
      158,
      181,
      216,
      109,
      102,
      65,
      194,
      231,
      203,
      12,
      14,
      71,
      120,
      101,
      106,
      211,
      156,
      113,
      81,
      174,
      192,
      185,
      243,
      236,
      24,
      26,
      201,
      63,
      74,
      80,
      14,
      73,
      111,
      224,
      248,
      22,
      74,
      202,
      56,
      9,
      161,
      207,
      64,
      131,
      83,
      220,
      119,
      54,
      70,
      181,
      51,
      232,
      240,
      29,
      111
    ]);
  });

  test('[BTC][ETH][EOS] currency', () {
    const mnemonic = 'soup animal leader blast feed need saddle rifle unit stumble stock pulp';
    final mc = MultiCurrency(mnemonic);

    final btcCurr = mc.getCurrency(Currency.BTC);
    expect(btcCurr.name, 'btc');
    expect(btcCurr.getPublicKey(), '039417b09121cf7f6aa86f92d4999ae035e1391a2e6a7c9fb70dc0b1d2991d749b');
    expect(btcCurr.getPrivateKey(), 'cVXNWa1MAbAyGZ4ERSiwwVp1xo8QacRHAwUxTbW49Ftf27BwGbg9');
    expect(btcCurr.getAddress(), completion(equals('muoy6CytsecJmqrkpxsgSsarw1nGfEnuYs')));

    final ethCurr = mc.getCurrency(Currency.ETH);
    expect(ethCurr.name, 'eth');
    expect(ethCurr.getPublicKey(), '0x0365a50abadc1141e2bf20b57a52bba3eba32595d2c1d4a2ff1d52c15828621169');
    expect(ethCurr.getPrivateKey(), '0x5559a586458230d3ff4d34b2ff7858ac44aef2482258f137d2cef596eb81330e');
    expect(ethCurr.getAddress(), completion('0x0a968229246d2ced14fa10608bd1af380f2d0387'));

    final eosCurr = mc.getCurrency(Currency.EOS);
    expect(eosCurr.name, 'eos');
    expect(eosCurr.getPublicKey(), 'EOS6o7NwJUP7ukYtaDZ3VWpEYnmrdqUfFqzu2HhkUu7L2WXahDYer');
    expect(eosCurr.getPrivateKey(), '5Jud2vaLLAbVg1Ms4rdrEzpnfsncvrTApRBUR5rGeKX8QkbUnhf');
    /* if haven't register account */
    expect(eosCurr.getAddress(), throwsException);
  });
}
