import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

import 'package:project_repository/repositories/auth_repository.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector(httpClient: HttpClient(apiUrl: "https://dummyjson.com", enableLogs: true, preventLargeResponses: false));
  final httpClient = repositoryInjector.get<HttpClient>();
  final authRepository = repositoryInjector.get<AuthRepository>();

  test('HttpClient', () async {
    print('\nHttpClient:');
    final response = await httpClient.request(
      path: '/test',
      method: HttpMethod.get,
    );
    final result = jsonEncode(response.data).toString();
    expect(result, '{"status":"ok","method":"GET"}');
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
