part of lecle_crypto;

class _CryptoService {
  static _CryptoService _sInstance;

  // ssc_project_inventis_lecle_development_key
  static final List<int> _generalKey = [];
  final _iv = IV.fromLength(16);
  String _key = '';
  Key _eKey;
  Encrypter _encrypter;
  bool _init = false;

  _CryptoService._();

  factory _CryptoService.shared() {
    if (_sInstance == null) {
      _sInstance = _CryptoService._();
    }
    return _sInstance;
  }

  static Future init({List<int> key}) async {
    _CryptoService._generalKey.clear();
    _CryptoService._generalKey.addAll(key);
    final shared = _CryptoService.shared();
    shared._encryptKey();
    shared._initEncrypter();
    shared._init = true;
  }

  void _encryptKey() {
    _key = _generalKey.map((e) => String.fromCharCode(e)).join('');
  }

  void _initEncrypter() {
    _eKey = Key.fromUtf8(_key.substring(0, 32));
    _encrypter = Encrypter(AES(_eKey));
  }

  String encrypt(String data) {
    if (!_init) {
      _invokeException();
      return data;
    }
    if (data == null || data.isEmpty) {
      return data;
    }
    try {
      final encrypted = _encrypter.encrypt(data, iv: _iv);
      return encrypted.base64;
    } catch (_) {
      return data;
    }
  }

  String decrypt(String base64) {
    if (!_init) {
      _invokeException();
      return base64;
    }
    if (base64 == null || base64.isEmpty) {
      return base64;
    }
    try {
      return _encrypter.decrypt(Encrypted.fromBase64(base64), iv: _iv);
    } catch (_) {
      return base64;
    }
  }

  void _invokeException() {
    throw Exception('Not init Crypto service yet.');
  }
}
