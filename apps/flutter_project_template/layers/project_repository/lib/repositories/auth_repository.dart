import 'dart:convert';

import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/repositories/user_repository.dart';
import 'package:project_repository/repositories/repository.dart';

enum LoginType { basic, token }

class AuthRepository extends Repository {
  const AuthRepository({
    required this.userRepository,
    required super.httpClient,
  });

  final UserRepository userRepository;

  bool _setBasicAuth(String userName, String password) {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$userName:$password'))}';
    return httpClient.setHeader('authorization', basicAuth);
  }

  bool _setAuthToken(String token) {
    return httpClient.setHeader('authorization', token);
  }

  bool _removeAuth() {
    return httpClient.setHeader('authorization', null);
  }

  Future<UserLoaded> _login(String userName, String password) async {
    final response = await httpClient.request(
      path: '/auth/login',
      method: HttpMethod.post,
      data: {'username': userName, 'password': password},
    );
    return UserLoaded.fromJson(response.data);
  }

  Future<UserLoaded> _basicAuthLogin({
    required String userName,
    required String password,
  }) async {
    _setBasicAuth(userName, password);
    final UserLoaded user = await userRepository.getUser(userName);
    userRepository.saveLoggedUser(user);
    return user;
  }

  Future<UserLoaded> _tokenAuthLogin({
    required String userName,
    required String password,
  }) async {
    final UserLoaded user = await _login('emilys', 'emilyspass');
    if (user.token != null) _setAuthToken(user.token!);
    userRepository.saveLoggedUser(user);
    return user;
  }

  Future<UserLoaded> login({
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
    return _removeAuth();
  }

  Future<UserLoaded> loggedUser() async {
    final UserLoaded user = await userRepository.getLoggedUser();
    if (user.token != null) _setAuthToken(user.token!);
    return user;
  }
}
