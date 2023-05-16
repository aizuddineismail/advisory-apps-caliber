import 'package:advisory_api/advisory_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage instance = SecureStorage();

  FlutterSecureStorage? _flutterSecureStorage;

  FlutterSecureStorage get storage {
    if (_flutterSecureStorage != null) {
      return _flutterSecureStorage!;
    }

    AndroidOptions getAndroidOptions() =>
        const AndroidOptions(encryptedSharedPreferences: true);
    _flutterSecureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());

    return _flutterSecureStorage!;
  }

  Future<Credential> getCredential() async {
    final id = await storage.read(key: 'id');
    final token = await storage.read(key: 'token');
    return Credential(id: id ?? '', token: token ?? '');
  }

  Future<void> storeToken({
    required String id,
    required String token,
  }) async {
    await storage.write(key: 'id', value: id);
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await storage.deleteAll();
  }
}
