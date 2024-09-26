import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/clients/secure_storage.dart';

import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_repository/repositories/user_repository.dart';
import 'package:project_repository/repositories/repository.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final httpClient = HttpClient(
    apiUrl: "https://dummyjson.com",
    enableLogs: true,
    preventLargeResponses: false,
  );
  final storage = SecureStorage();

  final userRepository = UserRepository(
    httpClient: httpClient,
    storage: storage,
  );

  final authRepository = AuthRepository(
    httpClient: httpClient,
    userRepository: userRepository,
  );

  test('HttpClient', () async {
    print('\nHttpClient:');
    final test = await httpClient.request<String?>(
      path: '/test',
      method: HttpMethod.get,
      onSuccess: (data) async => jsonEncode(data),
    );
    expect(test.toString(), '{"status":"ok","method":"GET"}');
  });

  test('Auth login', () async {
    print('\nAuth login:');
    final loginUser = await authRepository.login(userName: "martin", password: "test123", type: LoginType.token);
    expect(loginUser.firstName, 'Emily');
    expect(loginUser.lastName, 'Johnson');
    expect(loginUser.userName, 'emilys');
    expect(loginUser.token, isNotNull);
    expect(loginUser.token, isNotEmpty);
    expect(loginUser.token, hasLength(360));
  });

  test('Get logged user', () async {
    print('\nGet logged user:');
    final loggedUser = await authRepository.loggedUser();
    expect(loggedUser!, isNotNull);
    expect(loggedUser.firstName, 'Emily');
    expect(loggedUser.lastName, 'Johnson');
    expect(loggedUser.userName, 'emilys');
    expect(loggedUser.token, isNull);
  });
}
