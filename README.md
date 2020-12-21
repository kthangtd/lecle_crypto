# LECLE Crypto

Encrypt / Decrypt Data

## How to use?

### Init Service

```dart
void main() async {
  // private key min-length: 32
  final key = [114, 111, 106, 101,  99, 116,  95, 105, 
               110, 118, 101, 110, 116, 105, 115,  95, 
               108, 101,  99, 108, 101,  95, 100, 101, 
               118, 101, 108, 111, 112, 109, 101, 110];

  await initCryptoSrv(key: key);
}
```

### Encrypt

```dart
final encryptBase64 = cryptoSrv.encrypt('string');
```

### Decrypt

```dart
final originStr = cryptoSrv.decrypt('base-64-string');
```
