import 'package:bloc/bloc.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_state/core2.dart';

typedef _UserStateEmitter = Emitter<State<Exception, User>>;

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

class AuthBloc extends TripleBloc<AuthEvent, User, Exception> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super() {
    handle<AuthLogin>(_onLogin);
    handle<AuthShowUser>(_onShowUser);
    handle<AuthLogout>(_onLogout);
  }

  late final AuthRepository _authRepository;

  Future<void> _onLogin(AuthLogin event, _UserStateEmitter emit) async {
    try {
      emit.loading();
      final User user = await _authRepository.login(
        userName: event.userName,
        password: event.password,
        type: event.type,
      );
      emit.state(user);
    } catch (e, stackTrace) {
      emit.error(e);
    }
  }

  Future<void> _onShowUser(AuthShowUser event, _UserStateEmitter emit) async {
    try {
      emit.loading();
      emit.state(await _authRepository.loggedUser());
    } catch (e, stackTrace) {
      emit.error(e);
    }
  }

  void _onLogout(AuthLogout event, _UserStateEmitter emit) {
    try {
      _authRepository.logout();
      emit.reset();
    } catch (e, stackTrace) {
      emit.error(e);
    }
  }
}
