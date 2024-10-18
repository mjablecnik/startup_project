import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';
import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_state/bloc/auth_bloc.dart';
import 'package:project_state/events/auth_events.dart';
import 'package:project_state/states/auth_state.dart';
import 'package:test/test.dart';

import 'mock_data.dart';
import 'setup.dart';

void main() {
  late AuthBloc counterBloc;

  group(AuthBloc, () {
    setUp(() {
      setupData(fakeData, useFakeData: true);
      counterBloc = AuthBloc(authRepository: repositoryInjector.get<AuthRepository>());
    });
    tearDown(() => resetInjector());

    blocTest(
      'Auth Login',
      build: () => counterBloc,
      act: (bloc) => bloc.add(AuthLogin(
        userName: "emilys",
        password: "emilyspass",
        type: LoginType.token,
      )),
      expect: () => [
        UserState.loading(),
        UserState.success(expectedLoginUser),
      ],
    );

    blocTest(
      'Get logged user',
      build: () => counterBloc,
      act: (bloc) => bloc.add(AuthShowUser()),
      expect: () => [
        UserState.loading(),
        UserState.success(expectedLoggedUser),
      ],
    );
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
