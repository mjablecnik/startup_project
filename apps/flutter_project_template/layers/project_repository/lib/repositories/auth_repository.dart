import 'package:project_common/logger.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/exceptions.dart';
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
    return httpClient.createRequest(
      () => httpClient.dio.post('/auth/login', data: {
        'username': userName,
        'password': password,
      }),
      (data) async => User.fromJson(data),
    );
  }

  _basicAuthLogin({
    required String userName,
    required String password,
  }) async {
    try {
      restApiService.setBasicAuth(userName, password);
      final User user = await userRepository.getUser(userName);
      userRepository.saveLoggedUser(user);
      return user;
    } on ServerException catch (e) {
      logger.exception(e);
      return null;
    }
  }

  _tokenAuthLogin({
    required String userName,
    required String password,
  }) async {
    try {
      final User user = await _login('emilys', 'emilyspass');
      if (user.token != null) restApiService.setAuthToken(user.token!);
      userRepository.saveLoggedUser(user);
    } on ServerException catch (e) {
      logger.exception(e);
      return null;
    }
  }

  Future<User?> login({
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
      restApiService.setAuthToken(user.token!);
      return user;
    } catch (e) {
      return null;
    }
  }
}
