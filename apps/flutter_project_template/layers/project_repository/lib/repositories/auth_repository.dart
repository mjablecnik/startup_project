import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/repositories/user_repository.dart';
import 'package:project_repository/services/rest_api_service.dart';

enum LoginType { basic, token }

class AuthRepository {
  const AuthRepository({
    required this.restApiService,
    required this.userRepository,
    required this.httpClient,
  });

  final RestApiService restApiService;
  final UserRepository userRepository;
  final HttpClient httpClient;

  Future<User> _login(String userName, String password) {
    return httpClient.request(
      path: '/auth/login',
      method: HttpMethod.post,
      data: {'username': userName, 'password': password},
      onSuccess: (data) async => User.fromJson(data),
    );
  }

  Future<User> _basicAuthLogin({
    required String userName,
    required String password,
  }) async {
    restApiService.setBasicAuth(userName, password);
    final User user = await userRepository.getUser(userName);
    userRepository.saveLoggedUser(user);
    return user;
  }

  Future<User> _tokenAuthLogin({
    required String userName,
    required String password,
  }) async {
    final User user = await _login('emilys', 'emilyspass');
    if (user.token != null) restApiService.setAuthToken(user.token!);
    userRepository.saveLoggedUser(user);
    return user;
  }

  Future<User> login({
    required String userName,
    required String password,
    required LoginType type,
  }) async {
    switch (type) {
      case LoginType.basic:
        return _basicAuthLogin(userName: userName, password: password);
      case LoginType.token:
        return _tokenAuthLogin(userName: userName, password: password);
    }
  }

  bool logout() {
    userRepository.saveLoggedUser(null);
    return restApiService.removeAuth();
  }

  Future<User?> loggedUser() async {
    try {
      final User user = await userRepository.getLoggedUser();
      if (user.token != null) restApiService.setAuthToken(user.token!);
      return user;
    } catch (e) {
      return null;
    }
  }
}
