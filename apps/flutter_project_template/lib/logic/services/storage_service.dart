import 'package:flutter_project_template/core/app/global.dart';
import 'package:flutter_project_template/core/clients/secure_storage.dart';
import 'package:flutter_project_template/data/entities/user.dart';

class StorageService {
  StorageService({required SecureStorage storage}) {
    _storage = storage;
  }

  late final SecureStorage _storage;

  Future<User?> getLoggedUser() async {
    try {
      return User.fromJson(await _storage.getMap(StorageKey.loggedUser.name));
    } catch (e) {
      App.logger.error(e);
      return null;
    }
  }

  Future<void> saveLoggedUser(User? user) {
    if (user != null) {
      return _storage.saveMap(StorageKey.loggedUser.name, user.toJson());
    } else {
      return _storage.remove(StorageKey.loggedUser.name);
    }
  }

  Future<void> saveDeviceId(String deviceId) {
    return _storage.saveString(StorageKey.deviceId.name, deviceId);
  }

  Future<String?> getDeviceId() async {
    String? deviceId = await _storage.getString(StorageKey.deviceId.name);
    return deviceId;
  }
}
