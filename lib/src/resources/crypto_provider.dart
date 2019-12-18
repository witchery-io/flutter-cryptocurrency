import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:inject/inject.dart';
import '../models/balance.dart';
import 'http_provider.dart';

class CryptoProvider implements HttpProvider {
  Client client;

  final baseUrl = 'https://api.coven.in/public';

  @provide
  CryptoProvider({@required this.client});

  @override
  Future<Balance> getBalance(String curr, String address) async {
    Response response =
        await client.get("$baseUrl/$curr/test/address/$address");

    if (response.statusCode == 200) {
      return Balance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load full balance data');
    }
  }

  @override
  Future pushTx(String curr, String txHex) async {
    Response response = await client.post(
        "$baseUrl/$curr/test/transactions/send",
        body: json.encode({'rowTransaction': txHex}),
        headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed transaction');
    }
  }
}
