import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_data/entities/user.dart';
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

class AuthBloc extends Bloc<AuthEvent, User> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const User.initial()) {
    on<AuthShowUser>(_onShowUser);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  late final AuthRepository _authRepository;

  Future<void> _onLogin(AuthLogin event, Emitter<User> emit) async {
    try {
      emit(User.loading());
      final UserLoaded user = await _authRepository.login(
        userName: event.userName,
        password: event.password,
        type: event.type,
      );
      emit(user);
    } catch (e, stackTrace) {
      emit(User.error(e));
    }
  }

  Future<void> _onShowUser(AuthShowUser event, Emitter<User> emit) async {
    try {
      emit(User.loading());
      final UserLoaded user = await _authRepository.loggedUser();
      emit(user);
    } catch (e, stackTrace) {
      emit(User.error(e));
    }
  }

  void _onLogout(AuthLogout event, Emitter<User> emit) {
    try {
      _authRepository.logout();
      emit(User.initial());
    } catch (e, stackTrace) {
      emit(User.error(e));
    }
  }
}
