import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:multi_currency/multi_currency.dart';
import 'package:multi_currency/src/utils/tx.dart';
import 'package:flutter_test/flutter_test.dart';


main() {
  group('[BTC] transaction', () {
    test('[BTC] (negative price) (empty address)', () async {
      const mnemonic = 'limit boost flip evil regret shy alert always shine cabin unique angry';
      final cryptoCurrency = MultiCurrency(mnemonic);
      final btcCurr = cryptoCurrency.getCurrency(Currency.BTC);
      expect(btcCurr.transaction('muoy6CytsecJmqrkpxsgSsarw1nGfEnuYs', -0.0002), throwsArgumentError);
      expect(btcCurr.transaction('', 0.0002), throwsArgumentError);
      expect(btcCurr.transaction('muoy6CytsecJmqrkpxsgSsarw1nGfEnuYs', 9999.00), throwsException);
    });

    test('[BTC] Tx class', () async {
      final tx = Tx(
        senderAddress: 'mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU',
        balance: 8148312,
        address: 'muoy6CytsecJmqrkpxsgSsarw1nGfEnuYs',
        price: 220000,
        ecPair: ECPair.fromWIF('cQKqnYbYVMBgsUHHnPucb6QjRFZaw7MZBv89U5rN3kYodqUeXFJF'),
        outputs: [
          {'hash': 'f6ce386202b7ef9e84629055b851be3f0c2135929271343afeb5ab14b450d361', 'index': 0},
          {'hash': '638b0160ae86785d6ff2352f99fc9136c01f0dd646d253b1129362a238a1a972', 'index': 1},
          {'hash': '51648f46f83c930f8236b57bb67b7614c48461b6a75099674de2d33c054f5739', 'index': 0},
        ],
        fee: 100000.0,
      );

      tx.build();
      expect(tx.txHex, '010000000361d350b414abb5fe3a3471929235210c3fbe51b8559062849eefb7026238cef6000000006a4730440220236a6c3041a89accaa3b32b6e5612459db86f4a61665e502e9a00720d97b769602202a7f0933e8ef88a26315b7a03b1cd3e4ef9f045177e7f69cf284dc747dd8340101210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8cffffffff72a9a138a2629312b153d246d60d1fc03691fc992f35f26f5d7886ae60018b63010000006b483045022100df7b4f96b23ed6716b94f289b15e1f56f9c2248dd0330c8bf90fc6b3229406dc0220478a99e689d514867e11f2b8d6fcc29d247eb9a5b2ad3e36c4b1740e2034202901210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8cffffffff39574f053cd3e24d679950a7b66184c414767bb67bb536820f933cf8468f6451000000006a47304402205fa852c8f961ad575a819bbebcd9c42a60901a467f5566dac274bcda6aa36f0602206fe0b4e358bbd2354face271c4de8d318c55a9c76d5dfd3b4523976a3220e3fb01210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8cffffffff0258737700000000001976a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac605b0300000000001976a9149cc97f1fddb8b596c7501bd29985c62b68afb10488ac00000000');
    });
  });
}
