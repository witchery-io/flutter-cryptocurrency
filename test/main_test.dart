import './multi_currency_test.dart' as mc;
import './http_test.dart' as h;
import './tx_test.dart' as tx;
import 'package:flutter_test/flutter_test.dart';

main() {
  group('general test', () {
    mc.main();
    h.main();
    tx.main();
  });
}