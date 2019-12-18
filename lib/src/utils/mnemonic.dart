import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;

class Mnemonic {
  String mnemonic;

  Mnemonic(this.mnemonic);

  factory Mnemonic.generate() {
    return Mnemonic(bip39.generateMnemonic());
  }

  Uint8List get mnemonicToSeed {
    return bip39.mnemonicToSeed(mnemonic);
  }

  String get mnemonicToSeedHex {
    return bip39.mnemonicToSeedHex(mnemonic);
  }

  String get mnemonicToEntropy {
    return bip39.mnemonicToEntropy(mnemonic);
  }

  bool get isValid {
    return bip39.validateMnemonic(mnemonic);
  }

  @override
  String toString() {
    return mnemonic;
  }
}
