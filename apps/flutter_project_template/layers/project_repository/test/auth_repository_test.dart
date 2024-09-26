import 'package:mocktail/mocktail.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

import 'package:project_repository/repositories/auth_repository.dart';
import 'package:test/test.dart';

import 'mock_data.dart';
import 'setup.dart';

fakeData() {
  final httpClient = HttpClientMock();
  setupInjector(httpClient: httpClient);

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
}

void main() {
  setupData(fakeData, useFakeData: true);

  final authRepository = repositoryInjector.get<AuthRepository>();

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
    final user = User(firstName: 'Emily', lastName: 'Johnson', userName: 'emilys', token: null);
    expect(loggedUser, user);
  });
}
