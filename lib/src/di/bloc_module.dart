import 'package:http/http.dart' show Client;
import 'package:inject/inject.dart';

import '../resources/crypto_provider.dart';

@module
class BlocModule {
  @provide
  @singleton
  Client client() => Client();

  @provide
  @singleton
  CryptoProvider cryptoProvider(Client client) =>
      CryptoProvider(client: client);
}
