import 'package:flutter_test/flutter_test.dart';
import 'package:multi_currency/src/currencies/currencies.dart';
import 'package:multi_currency/src/multi_currency_base.dart';

void main() {
  test('multi account main net', () async {
    final mc = MultiCurrency(
        'limit boost flip evil regret shy alert always shine cabin unique angry',
        network: 'main');

    final list = await mc.currenciesByAccount(0);

    list.forEach((coin) async {
      if (coin is BTC) {
        coin.generateAddresses(next: 20);
        final addressList = await coin.addressList();
        expect(addressList.first.address, '12JZXTX5peeEo9Me8D42PksUKLcGmDy9A2');
      }
    });

    
    final list2 = await mc.currenciesByAccount(1);

    list2.forEach((coin) async {
      if (coin is BTC) {
        coin.generateAddresses(next: 20);
        final addressList = await coin.addressList();
        expect(addressList.first.address, '1GC2w2nEsgLhLNhCVLHHU4DGGHohLfdx6T');
      }
    });

    final list3 = await mc.currenciesByAccount(2);

    list3.forEach((coin) async {
      if (coin is BTC) {
        coin.generateAddresses(next: 20);
        final addressList = await coin.addressList();
        expect(addressList.first.address, '1E6hPVZTKBcgkFDLcWAetb8iCRDXJJJWAf');
      }
    });
  });

  test('[BTC][ETH][EOS] transaction builder', () async {
    const mnemonic =
        'limit boost flip evil regret shy alert always shine cabin unique angry';
    final mc = MultiCurrency(mnemonic, network: 'x');

    final curr = await mc.currenciesByAccount(0);
    curr.forEach((coin) {
      if (coin is BTC) {
        expect(coin.name, 'btc');

        final broadcast = coin.transactionBuilder(
          fee: 100000,
          address: 'mmLjG1HDCmnLkpzmDoEgkbS4yQsmA5ACCU',
          addressReceive: 'mjLA7rHbFSNdsEVvyPqx39Df87wf3wDiFR',
          price: 8888888,
          data: data,
        );

        expect(broadcast,
            '0100000004198f97e9eab5b399d1e9c4f72e65bbdb982a5a029e1033542749faa5636dda88000000006b4830450221008de201d9f57997f8f15913c49d5c48e3bfb3f2eefe451eec5e45fa7405eed71a02204f25a3461aa85a6ae58dc917cb1e2f923a226b64091ae74275bf936d9cee549301210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8cffffffff922117b52989f2f9563eb37c06c67a17099a083d08b74ecdd742da6ea1b00420010000006b483045022100ed8b92eaa03cab280ab65592fc5f61f2540ec26cc0b9c16406e16c67878e4b1b02200147d574caa074be373d8c5ff38eb7107382dc1d01a744885638181c7b74a4e1012103b6b5cb0c90a8d5a70307da26b0b8e94b3b0100414b4dca16ce41beee80e5781bffffffffe1b4867309a981ae1253224e9b9164b02059ba70e738fb789c4a73191099e806010000006a4730440220348458dc6552074c7f9458768015fa107bddd19d88c76d2ba5b3a87ef49692c802204592c5052bf926bba26eee3ff3424b24d9763d563d9f3f3f4c75cd2cdb7d445f0121025306a0bc553acc676decc1ce3be3a2ee2559acf7b083255060f0e77f7180c16affffffff1c1301e53c4db937f2be0897677172d741c31bb3e5c3250fa344e9c31340866c010000006b4830450221009d59b56fad8e83c5bc4246b139a84efc6fb421444ff3c09a407bf6d632c6640d02205aba9c302a0081171a19a655d25c1ee252a5c7d4dc1a118f411ae37b5300ffaf012102d681dae008dc7ddeeffa641a8b7581b54c6f47989695e5c53ac6c5a2166abb2bffffffff05dee26b00000000001976a9143fe1b6b8540f8a59a869e636982d8c97ef32205388ac5abf1b00000000001976a9143fe1b6b8540f8a59a869e636982d8c97ef32205388ac335f1e00000000001976a91429d5cc3c904769ae2aa912b2029c94398628337088ac10270000000000001976a91429d5cc3c904769ae2aa912b2029c94398628337088ac10270000000000001976a91429d5cc3c904769ae2aa912b2029c94398628337088ac00000000');
      } else if (coin is ETH) {
        expect(coin.name, 'eth');
      } else if (coin is EOS) {
        expect(coin.name, 'eos');
      } else {
        throw 'Invalid coin';
      }
    });
  });
}

final data = [
  TransactionBuilderArgs(
    'cQKqnYbYVMBgsUHHnPucb6QjRFZaw7MZBv89U5rN3kYodqUeXFJF',
    'mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU',
    7070430,
    [
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"
        ],
        "block_hash":
            "00000000e37e55441b38e6bcf163280f7c1199c9d0ab39d47dfbad231eefd7de",
        "block_height": 1665784,
        "confirmations": 3735,
        "confirmed": 1581593154,
        "fees": 100000,
        "hash":
            "88da6d63a5fa49275433109e025a2a98dbbb652ef7c4e9d199b3b5eae9978f19",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 7370430,
            "prev_hash":
                "ed547eaf9d9cb0d2a060c30bdddda7677864a1a3b0f9e066241f3f04eaa2b55f",
            "script":
                "483045022100eb8204099baaaec256b6f1744348b9feae032709ba80d3c32f31c439be507f8c0220441f94052a9b6185dcbf4e9c731f6ffc9a107527ec642692b0a92f5789fba11601210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 7070430
          },
          {
            "addresses": ["n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"],
            "script": "76a914eb4fdf2a4a30eca6ef22f4b4eb906dee9a4f173d88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 200000
          }
        ],
        "received": 1581592695,
        "size": 226,
        "total": 7270430,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"
        ],
        "block_hash":
            "000000008d2faef7f786d48f3d82e451ca80ffbb098fdf25917a60fb6c339ff5",
        "block_height": 1665783,
        "confirmations": 3736,
        "confirmed": 1581591951,
        "fees": 100000,
        "hash":
            "ed547eaf9d9cb0d2a060c30bdddda7677864a1a3b0f9e066241f3f04eaa2b55f",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 7670430,
            "prev_hash":
                "d0b5b83d697b3134c2f589c88aa7294820fd1b44d81fc5c863cb53026997881b",
            "script":
                "47304402207b20fd305f50e9b5e4fc42cb8f7a6a1231fc8e4634af4f62b5ff784d654434d90220377b9ba2c2a841e796ad573f90851edff24e1bd44e8deb0f0a78b1468a9a772801210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "88da6d63a5fa49275433109e025a2a98dbbb652ef7c4e9d199b3b5eae9978f19",
            "value": 7370430
          },
          {
            "addresses": ["n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"],
            "script": "76a914eb4fdf2a4a30eca6ef22f4b4eb906dee9a4f173d88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 200000
          }
        ],
        "received": 1581590804,
        "size": 225,
        "total": 7570430,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "mqYxBnq5Qxh7Njzm2RHqBYzjYR5XU97Spq"
        ],
        "block_hash":
            "0000000000000323630f6271ef222cddbc18e1134438e0c5057c3ac05d50b6ac",
        "block_height": 1634518,
        "confirmations": 35001,
        "confirmed": 1577102227,
        "fees": 100000,
        "hash":
            "d0b5b83d697b3134c2f589c88aa7294820fd1b44d81fc5c863cb53026997881b",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 7850430,
            "prev_hash":
                "a13fd2578c37aa00994040bae6a2f19e06988b50a0810d69736082fe2c81ac29",
            "script":
                "47304402205d64c647f6ebca4c84685f0baa312344ade34c7039b20d49c7eaefcdf770012202201212706debc763660c5a24fe1af75bdb08c1cf5e3c9b87be280fdf7f1be19f3a01210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "ed547eaf9d9cb0d2a060c30bdddda7677864a1a3b0f9e066241f3f04eaa2b55f",
            "value": 7670430
          },
          {
            "addresses": ["mqYxBnq5Qxh7Njzm2RHqBYzjYR5XU97Spq"],
            "script": "76a9146e11ffe72c044d0f690a9306a0d099c77785dafd88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 80000
          }
        ],
        "received": 1577101942,
        "size": 225,
        "total": 7750430,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "mqYxBnq5Qxh7Njzm2RHqBYzjYR5XU97Spq"
        ],
        "block_hash":
            "0000000000000b7c84ab73b0abd497142e61d3fbb26397c368c072df6a137982",
        "block_height": 1634514,
        "confirmations": 35005,
        "confirmed": 1577101677,
        "fees": 100000,
        "hash":
            "a13fd2578c37aa00994040bae6a2f19e06988b50a0810d69736082fe2c81ac29",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 8450430,
            "prev_hash":
                "f5ee16b2f76be8cdd9e9ce330e9fdaeeac0e5711b22c066e6a2ffea2a699acfc",
            "script":
                "483045022100b4e337df147227676a0bf93fce80c0b11e933488fbf06dd748a816222fd9e1f302207a74656924c2bd2903510d6bc911e75297c4cfd99f1e5bb9e1a9900503fc422501210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "d0b5b83d697b3134c2f589c88aa7294820fd1b44d81fc5c863cb53026997881b",
            "value": 7850430
          },
          {
            "addresses": ["mqYxBnq5Qxh7Njzm2RHqBYzjYR5XU97Spq"],
            "script": "76a9146e11ffe72c044d0f690a9306a0d099c77785dafd88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 500000
          }
        ],
        "received": 1577101592,
        "size": 226,
        "total": 8350430,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "msMWefXEXDRMRqnYRgaGZX6uyXWfNKHBJL"
        ],
        "block_hash":
            "0000000000003b3dad3103257b843365476cf589edc5e6e77f79391b2b5bbfc2",
        "block_height": 1630953,
        "confirmations": 38566,
        "confirmed": 1576833974,
        "fees": 100000,
        "hash":
            "f5ee16b2f76be8cdd9e9ce330e9fdaeeac0e5711b22c066e6a2ffea2a699acfc",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 1,
            "output_value": 990000,
            "prev_hash":
                "d13f3597c1ab56855a2be92a2765a243b743038fbc6107f0380b3fe1787f785d",
            "script":
                "47304402205e2f3dac92b60a8b5b9e39347cc59c84721aed561863d26920d42c0587e316bb02205629504755cb34ec9ff9d76d73b4717b5120ae15129822c662a7c7de3d9739c801210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          },
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 7570430,
            "prev_hash":
                "f18577fca2b6bef032db3803051bcb7b2f0b1f99fef8caa7a0d8912dcf7616f4",
            "script":
                "473044022001296a7030f5d41812ea49e8063be708539aeb278546a979bac7914af97bfd6402201beff4d68050f7b41798443b71b541d8bb0114f0c1ac64823a6a4f8cd280a2eb01210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "a13fd2578c37aa00994040bae6a2f19e06988b50a0810d69736082fe2c81ac29",
            "value": 8450430
          },
          {
            "addresses": ["msMWefXEXDRMRqnYRgaGZX6uyXWfNKHBJL"],
            "script": "76a91481d85bd2a45b1b9ba430b93345890e39f756db7888ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 10000
          }
        ],
        "received": 1576833958,
        "size": 372,
        "total": 8460430,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"
        ],
        "block_hash":
            "00000000000f51bf7ad21b2373f94c91e82bb2d809fa823d1549b069ddbcb1af",
        "block_height": 1626380,
        "confirmations": 43139,
        "confirmed": 1576676626,
        "fees": 100000,
        "hash":
            "d13f3597c1ab56855a2be92a2765a243b743038fbc6107f0380b3fe1787f785d",
        "inputs": [
          {
            "addresses": ["n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"],
            "output_index": 1,
            "output_value": 22334,
            "prev_hash":
                "18cf4962906b52122583f72424a98b34a5ecf7a294a56ce6da4c93edd595d5bc",
            "script":
                "473044022075cbab56b83feb39048590fc21179abe92739fb74416b1d5806fb0fc8c161a0e02204c0dbc71d4926094401a6c3fe871a340e72b410c41fe39f49d81848b475249de012102338b29771a40a57c7b5aae897f0bc0623a0f500e3d8a9e3a23abd19b0c59c9d3",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          },
          {
            "addresses": ["n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"],
            "output_index": 0,
            "output_value": 2272310,
            "prev_hash":
                "b8ee85b431f4eb7557038c9f24b9ad3357f428c95d73e43e4cb437e600717a68",
            "script":
                "48304502210084bda2a029b49c17a87b9ea96113af5871123eaf453e8d16851d096453b67a4502207470de05e67ebd867033f22d685582887b8833f238b89d35ec046ecb43f29101012102338b29771a40a57c7b5aae897f0bc0623a0f500e3d8a9e3a23abd19b0c59c9d3",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"],
            "script": "76a914eb4fdf2a4a30eca6ef22f4b4eb906dee9a4f173d88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "ba5ad632eed7591cff1e668c4b32045925c7467b8422e319f1acef41a6fa2082",
            "value": 1204644
          },
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "f5ee16b2f76be8cdd9e9ce330e9fdaeeac0e5711b22c066e6a2ffea2a699acfc",
            "value": 990000
          }
        ],
        "received": 1576676626,
        "size": 373,
        "total": 2194644,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"
        ],
        "block_hash":
            "000000000002395ac7c1e27448876be3e09977c1b502b98a49ec30e9cdcbf765",
        "block_height": 1625498,
        "confirmations": 44021,
        "confirmed": 1576667745,
        "fees": 100000,
        "hash":
            "f18577fca2b6bef032db3803051bcb7b2f0b1f99fef8caa7a0d8912dcf7616f4",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 8559318,
            "prev_hash":
                "18cf4962906b52122583f72424a98b34a5ecf7a294a56ce6da4c93edd595d5bc",
            "script":
                "48304502210082b247cdb45276d5d3576efe430ddc032a58ab38668d017706c8ef1416b7a0ac02207dee7b4fed0867d5cc979fe6c837b40afa944d059d4d197b76e38daf57fca6e001210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "f5ee16b2f76be8cdd9e9ce330e9fdaeeac0e5711b22c066e6a2ffea2a699acfc",
            "value": 7570430
          },
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "script": "76a914d92392ccbebef1518b7630dcb976889928bf6eb088ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "4e4fad156274f2efbc8f0c6a1a39878a47c6d1cd93fce2634ae88a2d41476902",
            "value": 888888
          }
        ],
        "received": 1576667745,
        "size": 226,
        "total": 8459318,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"
        ],
        "block_hash":
            "000000000000183fbf1a833669727bb63733efca1cbccf3d1512604739c7aa6f",
        "block_height": 1611359,
        "confirmations": 58160,
        "confirmed": 1575542426,
        "fees": 100000,
        "hash":
            "18cf4962906b52122583f72424a98b34a5ecf7a294a56ce6da4c93edd595d5bc",
        "inputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 1,
            "output_value": 444440,
            "prev_hash":
                "3c51da459b78e038b30ee13bde8f8245e927ba0e67e1570f76a44e42257a4b83",
            "script":
                "473044022005bcb2d6bc84702dbd0a4146a450bc929a1f564220c00610f2e7697e110c1937022054bf3e42639aef3854ac1cbe3dd018a2431bb9cb778b26de84566dd5ff5b184401210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          },
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 1,
            "output_value": 222200,
            "prev_hash":
                "74b7cbe2a826383cc4ecef60cc223815e963e054862cb2e503ea92925b4e584a",
            "script":
                "47304402207d04da9bd74bd60d2b5bd475cb2dacbfd8a366bea5df07266d4f52d9b110174e02200dd23a140534b3916bb99bf7bd182f5b1f71bc13d37d0275a327c8adf6cede3801210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          },
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "output_index": 0,
            "output_value": 8015012,
            "prev_hash":
                "25d2b8c69e8b8bc83987bbd4563ea2cc79ee3dc308bc771700be6c5335d3f1ce",
            "script":
                "4730440220576bb614cd73dcd047fb67ee27ec1994a3c0e8bf1c7c43fecac687fd0862fdae022006489ab71042a24bd2f9020e59525dfb1dc242b2c2ac111a8e8c19c3db8710ee01210347826e3b53185da5417b07785053759fa7e5a3a54dce0cb5d5f3c64f9e7e1d8c",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "f18577fca2b6bef032db3803051bcb7b2f0b1f99fef8caa7a0d8912dcf7616f4",
            "value": 8559318
          },
          {
            "addresses": ["n2yAmihxeJbd1hRrsxhEpegj3WU65JFMgG"],
            "script": "76a914eb4fdf2a4a30eca6ef22f4b4eb906dee9a4f173d88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "d13f3597c1ab56855a2be92a2765a243b743038fbc6107f0380b3fe1787f785d",
            "value": 22334
          }
        ],
        "received": 1575541564,
        "size": 519,
        "total": 8581652,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"
        ],
        "block_hash":
            "0000000000003a79d3289d2daffc435ea1b4b76048e7af92d616b79e5d79380d",
        "block_height": 1610952,
        "confirmations": 58567,
        "confirmed": 1575357647,
        "fees": 100000,
        "hash":
            "3c51da459b78e038b30ee13bde8f8245e927ba0e67e1570f76a44e42257a4b83",
        "inputs": [
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "output_index": 0,
            "output_value": 2435754,
            "prev_hash":
                "74b7cbe2a826383cc4ecef60cc223815e963e054862cb2e503ea92925b4e584a",
            "script":
                "483045022100b73b994f7b609f86cecbbebd2b00e7c3d9df5f80ee726fc09eff69cfed1f355c022036ef3a4c9950e9ecbd13e1230d743f9f1236ad1c047035a94b28b9a13bb8c90a01210250b9fa1566dba92b13c84f655eae6054ac1c77d5d6bfa8c053e41cb5f066c218",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "script": "76a914d92392ccbebef1518b7630dcb976889928bf6eb088ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "4e4fad156274f2efbc8f0c6a1a39878a47c6d1cd93fce2634ae88a2d41476902",
            "value": 1891314
          },
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "18cf4962906b52122583f72424a98b34a5ecf7a294a56ce6da4c93edd595d5bc",
            "value": 444440
          }
        ],
        "received": 1575356493,
        "size": 226,
        "total": 2335754,
        "version": 1
      },
      {
        "addresses": [
          "mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU",
          "n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"
        ],
        "block_hash":
            "000000000000013e77ed7cda9f1890914da82cc18022cda512c717dc1c9a3f83",
        "block_height": 1610950,
        "confirmations": 58569,
        "confirmed": 1575356162,
        "fees": 100000,
        "hash":
            "74b7cbe2a826383cc4ecef60cc223815e963e054862cb2e503ea92925b4e584a",
        "inputs": [
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "output_index": 1,
            "output_value": 33300,
            "prev_hash":
                "25d2b8c69e8b8bc83987bbd4563ea2cc79ee3dc308bc771700be6c5335d3f1ce",
            "script":
                "47304402207f6cd8f984c32601d4b096150c358f7382f747e5938e95f48733a3ee8b2543ca022025cbb933bb3908b56221f92eba62e5a5506b7b7e48579f0ff3275d050a5af3c901210250b9fa1566dba92b13c84f655eae6054ac1c77d5d6bfa8c053e41cb5f066c218",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          },
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "output_index": 1,
            "output_value": 2722294,
            "prev_hash":
                "dc93d57271452421d497680a0e6633f1a6709bd654dd728ae0e9bf4b7d9d98e4",
            "script":
                "483045022100cf758259062d7138975806b780612be54254ab89f53907c3a8db4c82a4709f9f022079dd446bafa38800cbd03ab3e485c9169f477b246060529958a0239fb6c9947001210250b9fa1566dba92b13c84f655eae6054ac1c77d5d6bfa8c053e41cb5f066c218",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          },
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "output_index": 0,
            "output_value": 2360,
            "prev_hash":
                "7808932e845820d88aee8df60c877543dcd587dd7598d383c79e93a2f2059641",
            "script":
                "473044022028ca879b5cd3ed81f377a7d42cec822861f540d74408817e9f146a2b1b9ecf80022046017c2b26467410b9ca109c184b901f58ea41d9c90e79ad7a7de02b74be1bcf01210250b9fa1566dba92b13c84f655eae6054ac1c77d5d6bfa8c053e41cb5f066c218",
            "script_type": "pay-to-pubkey-hash",
            "sequence": 4294967295
          }
        ],
        "lock_time": 0,
        "outputs": [
          {
            "addresses": ["n1K5YNEcgWXanFsinHhU8WStFx3ZBEyAp8"],
            "script": "76a914d92392ccbebef1518b7630dcb976889928bf6eb088ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "3c51da459b78e038b30ee13bde8f8245e927ba0e67e1570f76a44e42257a4b83",
            "value": 2435754
          },
          {
            "addresses": ["mgpWpWc4dg5VaFqFqn2QDg5oBLCyh2oCXU"],
            "script": "76a9140e4a59058a77c06195c2ee8e0fe4ce0bef05dfb688ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by":
                "18cf4962906b52122583f72424a98b34a5ecf7a294a56ce6da4c93edd595d5bc",
            "value": 222200
          }
        ],
        "received": 1575355913,
        "size": 520,
        "total": 2657954,
        "version": 1
      }
    ],
  ),
  TransactionBuilderArgs(
    'cMpuDenQn1SaN4gTQBEqTy6NE559iKaLTVgy3z174mVZwcMNF2E3',
    'msLBr624Uh26xNap5vpmcnWF1WMGfiDj9J',
    3908909,
    [
      {
        "addresses": [
          "2N3yV2WmTN7UZGpLEuL5Nv9NB8MbvgJsUTz",
          "2N8xZyp4t1aaMtfQtemkShfWY44j74tqbsk",
          "msLBr624Uh26xNap5vpmcnWF1WMGfiDj9J"
        ],
        "block_hash":
            "00000000000be359e9636c02db96215e2619d6a0a8e67060bb5057d7c90c4166",
        "block_height": 1666696,
        "confirmations": 2823,
        "confirmed": 1582641092,
        "fees": 52064,
        "hash":
            "2004b0a16eda42d7cd4eb7083d089a09177ac6067cb33e56f9f28929b5172192",
        "inputs": [
          {
            "addresses": ["2N8xZyp4t1aaMtfQtemkShfWY44j74tqbsk"],
            "output_index": 1,
            "output_value": 672907809,
            "prev_hash":
                "51c4a3900b14b90b1ef6676d7c17be03cb6f850e0c21199523857566cbf97720",
            "script": "1600146eb3f39a70e1b3c0dcddb804e0e307d90707bd13",
            "script_type": "pay-to-script-hash",
            "sequence": 4294967294
          }
        ],
        "lock_time": 1666695,
        "outputs": [
          {
            "addresses": ["2N3yV2WmTN7UZGpLEuL5Nv9NB8MbvgJsUTz"],
            "script": "a91475af481d648922afe4696a36f14160895747ac9f87",
            "script_type": "pay-to-script-hash",
            "spent_by":
                "d69e224385cbd17f10c38ec95229018ed7a1ee378007cbd127cb88a10e478c13",
            "value": 668946836
          },
          {
            "addresses": ["msLBr624Uh26xNap5vpmcnWF1WMGfiDj9J"],
            "script": "76a91481983f28b355106d4473f210bcbcade3ded6301888ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 3908909
          }
        ],
        "received": 1582639919,
        "size": 140,
        "total": 672855745,
        "version": 2
      }
    ],
  ),
  TransactionBuilderArgs(
    'cTJnYDtg7o9CVTSBFgpgCbP6np1ZhdHsdfTmUH45wvW31mS2jPAp',
    'mg1oMXbih1qbYnJvTJd2NMHyCMUdBPHUeN',
    10000,
    [
      {
        "addresses": [
          "2MtFfKiPobcnyJMvCsPGbNG39o4oih86msz",
          "2N1qDJCUTY8Ah2R2rsHAw5gebzBuwFbc6uM",
          "mg1oMXbih1qbYnJvTJd2NMHyCMUdBPHUeN"
        ],
        "block_hash":
            "0000000000003c84affe811b7561fdb518e0bba1cff3a7b8d10e6b007c26d6e5",
        "block_height": 1667214,
        "confirmations": 2305,
        "confirmed": 1583157425,
        "fees": 168,
        "hash":
            "06e8991019734a9c78fb38e770ba5920b064919b4e225312ae81a9097386b4e1",
        "inputs": [
          {
            "addresses": ["2N1qDJCUTY8Ah2R2rsHAw5gebzBuwFbc6uM"],
            "output_index": 1,
            "output_value": 8282001,
            "prev_hash":
                "f4603d724a53b746cbf466294c7a45bb00de9f053cbf929551fa2e9cb31ee3b5",
            "script": "16001489bbe911ac7aba8ae6d188f02e8f268c20a7bac3",
            "script_type": "pay-to-script-hash",
            "sequence": 4294967294
          }
        ],
        "lock_time": 1667213,
        "outputs": [
          {
            "addresses": ["2MtFfKiPobcnyJMvCsPGbNG39o4oih86msz"],
            "script": "a9140b0d463e102683e0405e5265a6713638348dc70e87",
            "script_type": "pay-to-script-hash",
            "spent_by":
                "36b989b886704bd21e8e47737664b8da6c417d9c77f1cf94a372b4212d405cb4",
            "value": 8271833
          },
          {
            "addresses": ["mg1oMXbih1qbYnJvTJd2NMHyCMUdBPHUeN"],
            "script": "76a9140574999e7b8f5712549b31cb38fe270951f271ae88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 10000
          }
        ],
        "received": 1583157170,
        "size": 140,
        "total": 8281833,
        "version": 2
      }
    ],
  ),
  TransactionBuilderArgs(
    'cNeXv67PCJinNNjGCX525g3pNEU8eWUdnscNNM8Nm2gXpDDLwAUB',
    'mt2no1xg8WtcKZHdFAt3MsyUZ12taT1D3K',
    10000,
    [
      {
        "addresses": [
          "2N6gUDhrBuH6PnvcY6a2DFqzd4SiR98DrcP",
          "2N9ciXMgd74koU32mkZXzTr9uL93v3wh2Tu",
          "mt2no1xg8WtcKZHdFAt3MsyUZ12taT1D3K"
        ],
        "block_hash":
            "000000000010769143442328c8cacd4c63e941c195c3b75c13ac1107b01f7b69",
        "block_height": 1667421,
        "confirmations": 2098,
        "confirmed": 1583250184,
        "fees": 168,
        "hash":
            "6c864013c3e944a30f25c3e5b31bc341d77271679708bef237b94d3ce501131c",
        "inputs": [
          {
            "addresses": ["2N9ciXMgd74koU32mkZXzTr9uL93v3wh2Tu"],
            "output_index": 1,
            "output_value": 4413016,
            "prev_hash":
                "f9d6c2bcfed5c0df8b6c870a764728c1af5bb9d2ce0a25bb9bd5377ef1d6f4e7",
            "script": "160014c27423fa889917b68c811044c79cb096510f3895",
            "script_type": "pay-to-script-hash",
            "sequence": 4294967294
          }
        ],
        "lock_time": 1667420,
        "outputs": [
          {
            "addresses": ["2N6gUDhrBuH6PnvcY6a2DFqzd4SiR98DrcP"],
            "script": "a914935fe9fc6484264bee85ad1e03af8aa20583548a87",
            "script_type": "pay-to-script-hash",
            "spent_by":
                "39f3b8d0c163ea8f37faa2ebff85a73f1036774c7042377fb7ed055558af870b",
            "value": 4402848
          },
          {
            "addresses": ["mt2no1xg8WtcKZHdFAt3MsyUZ12taT1D3K"],
            "script": "76a91489460eba57293dbaa6465957097eb941cb8c20dc88ac",
            "script_type": "pay-to-pubkey-hash",
            "spent_by": "",
            "value": 10000
          }
        ],
        "received": 1583249175,
        "size": 140,
        "total": 4412848,
        "version": 2
      }
    ],
  ),
];

class TransactionBuilderArgs {
  final String privateKey;
  final String address;
  final int balance;
  final txs;

  TransactionBuilderArgs(this.privateKey, this.address, this.balance, this.txs);
}
