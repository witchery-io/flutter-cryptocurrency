import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:inject/inject.dart';
import 'package:multi_currency/src/models/models.dart';
import 'package:multi_currency/src/resources/http_provider.dart';

class CryptoProvider implements HttpProvider {
  final Client client;
  final baseUrl = 'https://7af18e82.ngrok.io/public';

  @provide
  CryptoProvider({@required this.client});

  @override
  Future<Balance> getBalance(String curr, String address) async {
    final url = "$baseUrl/$curr/test/address/$address";
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return Balance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.body}');
    }
  }

  @override
  Future pushTx(String curr, String txHex) async {
    Response response = await client.post(
        "$baseUrl/$curr/test/transactions/send",
        body: json.encode({'rowTransaction': txHex}),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('${response.body}');
    }
  }
}
