import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

import 'package:project_repository/repositories/auth_repository.dart';
import 'package:test/test.dart';

import 'mock_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final httpClient = HttpClientMock();
  setupInjector(httpClient: httpClient);
  final authRepository = repositoryInjector.get<AuthRepository>();

  when(() => httpClient.request(path: '/test', method: HttpMethod.get))
      .thenAnswer((i) => Future.value(HttpResponse('{"status":"ok","method":"GET"}')));

  when(() => httpClient.setHeader('authorization', any())).thenReturn(true);

  when(
    () => httpClient.request(
      path: '/auth/login',
      method: HttpMethod.post,
      data: {'username': 'emilys', 'password': 'emilyspass'},
    ),
  ).thenAnswer((i) => Future.value(userLoginResponse));

  when(
    () => httpClient.request(
      path: '/auth/me',
      method: HttpMethod.get,
    ),
  ).thenAnswer((i) => Future.value(userDetailResponse));

  test('HttpClient', () async {
    final response = await httpClient.request(path: '/test', method: HttpMethod.get);
    final result = response.data;
    expect(result, '{"status":"ok","method":"GET"}');
  });

  test('Auth login', () async {
    final loginUser = await authRepository.login(userName: "martin", password: "test123", type: LoginType.token);
    expect(loginUser.firstName, 'Emily');
    expect(loginUser.lastName, 'Johnson');
    expect(loginUser.userName, 'emilys');
    expect(loginUser.token, isNotNull);
    expect(loginUser.token, isNotEmpty);
    expect(loginUser.token, hasLength(360));
  });

  test('Get logged user', () async {
    final loggedUser = await authRepository.loggedUser();
    expect(loggedUser!, isNotNull);
    expect(loggedUser.firstName, 'Emily');
    expect(loggedUser.lastName, 'Johnson');
    expect(loggedUser.userName, 'emilys');
    expect(loggedUser.token, isNull);
  });
}
