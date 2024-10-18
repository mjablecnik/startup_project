import 'package:project_repository/repositories/auth_repository.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthShowUser extends AuthEvent {
  const AuthShowUser();
}

final class AuthLogin extends AuthEvent {
  const AuthLogin({
    required this.userName,
    required this.password,
    required this.type,
  });

  final String userName;
  final String password;
  final LoginType type;
}

final class AuthLogout extends AuthEvent {
  const AuthLogout();
}
