import 'package:biometrics_auth_poc/core/persistence/secure_storage/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDataStorage extends SecureStorage {
  // Weird key to minimize collision chance.
  final _initKey = '_init';
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> initialize() async {
    try {
      final first = await _storage.read(key: _initKey);
      if (first == null || first == '1') {
        await _storage.deleteAll();
        await _storage.write(key: _initKey, value: '0');
      }
    } catch (e) {
      // TODO: Add logger.
      // No-op.
    }
  }

  @override
  Future<void> write(String key, String value) async =>
      _storage.write(key: key, value: value);

  @override
  Future<String?> read(String key) async => _storage.read(key: key);

  @override
  Future<void> remove(String key) async => _storage.delete(key: key);

  @override
  Future<void> clear() async => _storage.deleteAll();
}
