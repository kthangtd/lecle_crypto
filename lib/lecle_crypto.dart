library lecle_crypto;

import 'package:flutter/material.dart' show required;
import 'package:encrypt/encrypt.dart';

part 'src/crypto_srv.dart';

Future initCryptoSrv({@required List<int> key}) async {
  assert(key != null && key.length > 32);
  return _CryptoService.init(key: key);
}

_CryptoService get cryptoSrv => _CryptoService.shared();
