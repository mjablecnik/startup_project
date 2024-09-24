
import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/secure_storage.dart';
import 'package:project_repository/global.dart';
import 'package:talker/talker.dart';

class StorageService {
  StorageService({required SecureStorage storage, required this.logger}) {
    _storage = storage;
  }

  late final SecureStorage _storage;
  final Talker logger;

  Future<User?> getLoggedUser() async {
    try {
      return User.fromJson(await _storage.getMap(StorageKey.loggedUser.name));
    } catch (e) {
      logger.error(e);
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
