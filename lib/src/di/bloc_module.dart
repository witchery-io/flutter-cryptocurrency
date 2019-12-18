import '../resources/crypto_provider.dart';
import 'package:http/http.dart' show Client;
import 'package:inject/inject.dart';

@module
class BlocModule {
  @provide
  @singleton
  Client client() => Client();

  @provide
  @singleton
  CryptoProvider cryptoProvider(Client client) => CryptoProvider(client: client);
}
