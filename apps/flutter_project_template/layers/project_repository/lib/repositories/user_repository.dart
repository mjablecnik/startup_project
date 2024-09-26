import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/clients/secure_storage.dart';
import 'package:project_repository/global.dart';

class UserRepository {
  UserRepository({required HttpClient httpClient, required SecureStorage storage}) {
    _httpClient = httpClient;
    _storage = storage;
  }

  late final HttpClient _httpClient;
  late final SecureStorage _storage;

  Future<UserLoaded> getLoggedUser() async {
    try {
      return UserLoaded.fromJson(await _storage.getMap(StorageKey.loggedUser.name));
    } catch (e) {
      final response = await _httpClient.request(
        path: '/auth/me',
        method: HttpMethod.get,
      );
      return UserLoaded.fromJson(response.data);
    }
  }

  Future<UserLoaded> getUser(String userName) async {
    Future.delayed(const Duration(seconds: 1));
    return UserLoaded(firstName: "John", lastName: "Doe", userName: userName);
  }

  Future<void> saveLoggedUser(User? user) {
    if (user != null) {
      return _storage.saveMap(StorageKey.loggedUser.name, user.toJson());
    } else {
      return _storage.remove(StorageKey.loggedUser.name);
    }
  }
}
