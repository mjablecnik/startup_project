import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_data/entities/user.dart';
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

  test('Auth login', () async {
    final loginUser = await authRepository.login(userName: "martin", password: "test123", type: LoginType.token);
    final user = User(firstName: 'Emily', lastName: 'Johnson', userName: 'emilys', token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjczNTc3NzEsImV4cCI6MTcyNzM2MTM3MX0.-_tQ6x_6jp_8Q8g5yGaYSdB57M81jpKlo5O3zNpJTcs');
    expect(loginUser, user);
  });

  test('Get logged user', () async {
    final loggedUser = await authRepository.loggedUser();
    final user = User(firstName: 'Emily', lastName: 'Johnson', userName: 'emilys', token: null);
    expect(loggedUser, user);
  });
}
