import 'package:mocktail/mocktail.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';
import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_state/bloc/auth3_bloc.dart';
import 'package:test/test.dart';

import 'mock_data.dart';
import 'setup.dart';

void main() {
  test('AuthBloc test', () async {
    print('Test123:');
    final testVar = 10;
    expect(testVar, 10);
  });

  group(AuthBloc, () {
    late AuthBloc counterBloc;

    setUp(() {
      setupData(fakeData, useFakeData: true);
      counterBloc = AuthBloc(authRepository: repositoryInjector.get<AuthRepository>());
    });

    test('initial state is 0', () {
      expect(counterBloc.state, UserState.init());
    });
  });
}

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
