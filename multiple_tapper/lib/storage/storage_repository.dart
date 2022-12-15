import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageRepository {
  static const _androidOptions =
      AndroidOptions(encryptedSharedPreferences: true);
  static const _iosOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static const _storage =
      FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iosOptions);

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<Map> readAll() async {
    final result = await _storage.readAll();
    return result;
  }
}
