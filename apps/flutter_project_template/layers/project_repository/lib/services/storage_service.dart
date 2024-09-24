
import 'package:project_common/logger.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/secure_storage.dart';
import 'package:project_repository/global.dart';

class StorageService {
  StorageService({required SecureStorage storage}) {
    _storage = storage;
  }

  late final SecureStorage _storage;

  Future<User?> getLoggedUser() async {
    try {
      return User.fromJson(await _storage.getMap(StorageKey.loggedUser.name));
    } catch (e) {
      logger.exception(e);
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
}
