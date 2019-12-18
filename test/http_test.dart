import 'package:flutter_test/flutter_test.dart';
import 'package:multi_currency/src/models/balance.dart';
import 'package:multi_currency/src/resources/crypto_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' show Client, Response;
import 'dart:convert';

void main() {
  MockHttpProvider http;
  CryptoProvider crypto;

  final balance = Balance.fromJson(fakeBalanceResponse);

  void stubGet(String url, Response response) { // Response
    when(http.get(argThat(startsWith(url))))
        .thenAnswer((_) async => response);
  }

  void stubPost(String url, Response response) { // Response
    when(http.post(argThat(startsWith(url)), body: anyNamed('body')))
        .thenAnswer((_) async => response);
  }

  setUp(() {
    http = MockHttpProvider();
    crypto = CryptoProvider(client: http);
  });

  test('Get balance by address', () async {
    final expected = balance;
    stubGet(crypto.baseUrl, Response(json.encode(fakeBalanceResponse), 200));
    final result = await crypto.getBalance('btc', 'mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU');
    expect(result, isInstanceOf<Balance>());
    expect(expected.balance, result.balance);
  });

  test('[Error] get balance status code 500', () async {
    stubGet(crypto.baseUrl, Response('Failed to load full address data', 500));
    expect(crypto.getBalance('btc', 'mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU'), throwsException);
  });

  test('Push Transaction', () {
    stubPost(crypto.baseUrl, Response(json.encode("Success"), 200));
    final result = crypto.pushTx('btc', '010000000139574f053cd3e24d679950a7b66184c414767bb67bb536820f933cf8468f6451000000006b483045022100c72dd917a20106c78a5d70f79e76869d4ca91fada3ec2941e6197f948b86f8b902201bd2dc260273a928fb7a14387ac0af14f63773146f8e5394efdc17bec76b8eda01210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8cffffffff0210ad4b00000000001976a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac7b680300000000001976a914cca91d6fe8d5f0ad4ccf3a672fa7f4ec72e36d4988ac00000000');
    expect(result, completion('Success'));
  });

  test('[Error] push tx server status 500', () async {
    stubPost(crypto.baseUrl, Response('Failed tx', 500));
    expect(crypto.pushTx('btc', '010000000139574f053cd3e24d679950a7b66184c414767bb67bb536820f933cf8468f6451000000006b483045022100c72dd917a20106c78a5d70f79e76869d4ca91fada3ec2941e6197f948b86f8b902201bd2dc260273a928fb7a14387ac0af14f63773146f8e5394efdc17bec76b8eda01210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8cffffffff0210ad4b00000000001976a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac7b680300000000001976a914cca91d6fe8d5f0ad4ccf3a672fa7f4ec72e36d4988ac00000000'), throwsException);
  });

  tearDown(() {
    http.close();
    clearInteractions(http);
    reset(http);
    http = null;
    crypto = null;
  });
}

const fakeBalanceResponse = {
  "address": "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
  "total_received": 5182959,
  "total_sent": 0,
  "balance": 5182959,
  "unconfirmed_balance": 0,
  "final_balance": 5182959,
  "n_tx": 1,
  "unconfirmed_n_tx": 0,
  "final_n_tx": 1,
  "txs": [
    {
      "block_hash": "00000000000002ddf5a5a3ca77e03963013430d49db8e6244a909cc6c133597f",
      "block_height": 1610015,
      "block_index": 14,
      "hash": "51648f46f83c930f8236b57bb67b7614c48461b6a75099674de2d33c054f5739",
      "addresses": [
        "2N2JsQLsX9nexFwuwUncyzp3BZSLPfh7mu7",
        "2N3A6JkLzTSz47AERbhSDKnwgGPAJvPvqAB",
        "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"
      ],
      "total": 7526885715,
      "fees": 19368,
      "size": 140,
      "preference": "high",
      "relayed_by": "35.195.234.115:18333",
      "confirmed": "2019-11-27T09:55:17Z",
      "received": "2019-11-27T09:47:43.523Z",
      "ver": 2,
      "lock_time": 1610014,
      "double_spend": false,
      "vin_sz": 1,
      "vout_sz": 2,
      "confirmations": 1,
      "confidence": 1,
      "inputs": [
        {
          "prev_hash": "4b1d516f23c3b9cc51a33dbbf590f0357ec0164881e95a9f8811dc9f091917d0",
          "output_index": 1,
          "script": "16001431fccb891cd69f058e42aee27ff3698b766f23a7",
          "output_value": 7526905083,
          "sequence": 4294967294,
          "addresses": [
            "2N3A6JkLzTSz47AERbhSDKnwgGPAJvPvqAB"
          ],
          "script_type": "pay-to-script-hash",
          "age": 1610014
        }
      ],
      "outputs": [
        {
          "value": 5182959,
          "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
          "addresses": [
            "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"
          ],
          "script_type": "pay-to-pubkey-hash"
        },
        {
          "value": 7521702756,
          "script": "a91463699cbcded80c74e2f35b838643087bf76a973f87",
          "addresses": [
            "2N2JsQLsX9nexFwuwUncyzp3BZSLPfh7mu7"
          ],
          "script_type": "pay-to-script-hash"
        }
      ]
    }
  ]
};

class MockHttpProvider extends Mock implements Client {}