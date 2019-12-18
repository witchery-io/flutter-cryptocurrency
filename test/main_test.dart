import './multi_currency_test.dart' as cc;
import './http_test.dart' as h;
import './tx_test.dart' as tx;
import 'package:flutter_test/flutter_test.dart';

main() {
  group('general test', () {
    cc.main();
    h.main();
    tx.main();
  });
}