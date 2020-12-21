import 'package:flutter_test/flutter_test.dart';

import 'package:lecle_crypto/lecle_crypto.dart';

void main() {
  const List<int> _general_key = [115, 115, 99, 95, 112, 114, 111, 106, 101, 99, 116, 95, 105, 110, 118, 101, 110, 116, 105, 115, 95, 108, 101, 99, 108, 101, 95, 100, 101, 118, 101, 108, 111, 112, 109, 101, 110, 116, 95, 107, 101, 121];
  const long_Data = '''How can you ensure that your app continues to work as you add more features or change existing functionality? By writing tests.

Unit tests are handy for verifying the behavior of a single function, method, or class. The test package provides the core framework for writing unit tests, and the flutter_test package provides additional utilities for testing widgets.

This recipe demonstrates the core features provided by the test package using the following steps:

Add the test or flutter_test dependency.
Create a test file.
Create a class to test.
Write a test for our class.
Combine multiple tests in a group.
Run the tests.
For more information about the test package, see the test package documentation.

''';

  test('not init service yet', () {
    expect(() => cryptoSrv.encrypt('test'), throwsA(isInstanceOf<Exception>()));
    expect(() => cryptoSrv.decrypt('test'), throwsA(isInstanceOf<Exception>()));
  });

  test('init service wrong key', () async {
    final shortKey = [1, 2, 3];
    expect(() async => initCryptoSrv(key: null), throwsA(isInstanceOf<AssertionError>()));
    expect(() async => initCryptoSrv(key: []), throwsA(isInstanceOf<AssertionError>()));
    expect(() async => initCryptoSrv(key: shortKey), throwsA(isInstanceOf<AssertionError>()));
    expect(await initCryptoSrv(key: _general_key), isInstanceOf<dynamic>());
  });

  test('init service', () async {
    await initCryptoSrv(key: _general_key);
    final data = 'test';
    final encryptData = cryptoSrv.encrypt(data);
    expect(encryptData != null, true);
    expect(encryptData.isNotEmpty, true);

    final decryptData = cryptoSrv.decrypt(encryptData);
    expect(decryptData != null, true);
    expect(decryptData.isNotEmpty, true);
    expect(decryptData, data);
  });

  test('long data', () async {
    await initCryptoSrv(key: _general_key);

    final encryptData = cryptoSrv.encrypt(long_Data);
    final decryptData = cryptoSrv.decrypt(encryptData);
    expect(decryptData, long_Data);
  });

  test('fast encrypt', () async {
    await initCryptoSrv(key: _general_key);
    for (int i = 0; i < 1000; i++) {
      final ret = cryptoSrv.encrypt(long_Data);
      expect(ret != null, true);
      expect(ret.isNotEmpty, true);
    }
  }, timeout: Timeout(Duration(milliseconds: 200)));

  test('fast decrypt', () async {
    await initCryptoSrv(key: _general_key);
    for (int i = 0; i < 1000; i++) {
      final ret = cryptoSrv.encrypt(long_Data);
      expect(ret != null, true);
      expect(ret.isNotEmpty, true);
      final decryptData = cryptoSrv.decrypt(ret);
      expect(decryptData, long_Data);
    }
  }, timeout: Timeout(Duration(milliseconds: 400)));
}
