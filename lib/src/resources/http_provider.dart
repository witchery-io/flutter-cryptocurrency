import 'package:multi_currency/src/models/models.dart';

abstract class HttpProvider {
  Future<Balance> getBalance(String curr, String address);

  Future pushTx(String curr, String txHash);
}