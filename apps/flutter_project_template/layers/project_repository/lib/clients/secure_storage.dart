import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class SecureStorageMock extends Mock implements SecureStorage {}

class SecureStorage {
  late final FlutterSecureStorage _storage;

  SecureStorage() {
    _storage = const FlutterSecureStorage();
  }

  Future<void> remove(String key) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return Future.value();
    return _storage.delete(key: key);
  }

  Future<void> saveString(String key, String value) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return Future.value();
    return _storage.write(key: key, value: value);
  }

  Future<String?> getString(String key) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return Future.value();
    return _storage.read(key: key);
  }

  Future<void> saveMap(String key, Map value) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return Future.value();
    return _storage.write(key: key, value: json.encode(value));
  }

  Future<dynamic> getMap(String key) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return Future.value();
    return json.decode((await _storage.read(key: key)).toString());
  }
}
