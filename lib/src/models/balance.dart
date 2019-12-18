import 'transaction.dart';

class Balance {
  final String address;
  final int balance;
  final int finalBalance;
  final int totalReceived;
  final int totalSent;
  final int txCount;

  final List<Transaction> txs;

  Balance({
    this.address,
    this.balance,
    this.finalBalance,
    this.totalReceived,
    this.totalSent,
    this.txCount,
    this.txs,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      address: json['address'],
      balance: json['balance'],
      finalBalance: json['final_balance'],
      totalReceived: json['total_received'],
      totalSent: json['total_sent'],
      txCount: json['txCount'],
      txs: List.of(json['txs']).map((tx) => Transaction.fromJson(tx)).toList(),
    );
  }
}
