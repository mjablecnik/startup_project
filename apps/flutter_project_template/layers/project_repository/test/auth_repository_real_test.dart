import 'package:flutter/widgets.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

import 'package:project_repository/repositories/auth_repository.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector(httpClient: HttpClient(apiUrl: "https://dummyjson.com", enableLogs: true, preventLargeResponses: false));
  final authRepository = repositoryInjector.get<AuthRepository>();

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
    final user = User(firstName: 'Emily', lastName: 'Johnson', userName: 'emilys', token: null);
    expect(loggedUser, user);
  });
}
