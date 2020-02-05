import 'package:bip32/bip32.dart' as bip32;

final testNet = bip32.NetworkType(
  bip32: bip32.Bip32Type(public: 0x043587CF, private: 0x04358394),
  wif: 0x81,
);

final mainNet = bip32.NetworkType(
  bip32: bip32.Bip32Type(public: 0x0488B21E, private: 0x0488ADE4),
  wif: 0x80,
);
