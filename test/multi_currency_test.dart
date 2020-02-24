import 'package:flutter_test/flutter_test.dart';
import 'package:multi_currency/multi_currency.dart';
import 'package:multi_currency/src/currencies/currencies.dart';

void main() {
  test('[BTC][ETH][EOS] currency', () async {
    const mnemonic =
        'soup animal leader blast feed need saddle rifle unit stumble stock pulp';
    final mc = MultiCurrency(mnemonic);

    final curr = await mc.getCurrencies;
    curr.forEach((coin) {
      if (coin is BTC) {
        expect(coin.name, 'btc');
        expect(coin.getPublicKey(),
            '039417b09121cf7f6aa86f92d4999ae035e1391a2e6a7c9fb70dc0b1d2991d749b');
        expect(coin.getPrivateKey(),
            'cVXNWa1MAbAyGZ4ERSiwwVp1xo8QacRHAwUxTbW49Ftf27BwGbg9');
        expect(coin.getAddress(),
            completion(equals('muoy6CytsecJmqrkpxsgSsarw1nGfEnuYs')));
      } else if (coin is ETH) {
        expect(coin.name, 'eth');
        expect(coin.getPublicKey(),
            '0x0365a50abadc1141e2bf20b57a52bba3eba32595d2c1d4a2ff1d52c15828621169');
        expect(coin.getPrivateKey(),
            '0x5559a586458230d3ff4d34b2ff7858ac44aef2482258f137d2cef596eb81330e');
        expect(coin.getAddress(),
            completion('0x0a968229246d2ced14fa10608bd1af380f2d0387'));
      } else if (coin is EOS) {
        expect(coin.name, 'eos');
        expect(coin.getPublicKey(),
            'EOS6o7NwJUP7ukYtaDZ3VWpEYnmrdqUfFqzu2HhkUu7L2WXahDYer');
        expect(coin.getPrivateKey(),
            '5Jud2vaLLAbVg1Ms4rdrEzpnfsncvrTApRBUR5rGeKX8QkbUnhf');
      } else {
        throw 'Invalid coin';
      }
    });
  });
}
