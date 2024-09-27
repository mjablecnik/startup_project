import 'package:bloc/bloc.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_state/core.dart';

class UserStateInit extends UserState {
  const UserStateInit([User? state]) : super(data: state);
}
class UserStateLoading extends UserState {
  const UserStateLoading() : super(isLoading: true);
}
class UserStateError extends UserState {
  const UserStateError(Exception e) : super(error: e);
}
class UserStateSuccess extends UserState {
  const UserStateSuccess(User state) : super(data: state);
}

abstract class UserState {
  final bool isLoading;
  final Exception? error;
  final User? data;

  const UserState({
    this.isLoading = false,
    this.error,
    this.data,
  });

  factory UserState.init([User? user]) = UserStateInit;
  factory UserState.reset([User? user]) = UserStateInit;
  factory UserState.loading() = UserStateLoading;
  factory UserState.error(Exception error) = UserStateError;
  factory UserState.success(User user) = UserStateSuccess;
}

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

class AuthBloc extends Bloc<AuthEvent, UserState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(UserState.init()) {
    on<AuthShowUser>(_onShowUser);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  late final AuthRepository _authRepository;

  Future<void> _onLogin(AuthLogin event, Emitter<UserState> emit) async {
    try {
      emit(UserState.loading());
      final UserState user = UserState.success(
        await _authRepository.login(
          userName: event.userName,
          password: event.password,
          type: event.type,
        ),
      );
      emit(user);
    } catch (e, stackTrace) {
      emit(UserState.error(e as Exception));
    }
  }

  Future<void> _onShowUser(AuthShowUser event, Emitter<UserState> emit) async {
    try {
      emit(UserState.loading());
      final UserState user = UserState.success(await _authRepository.loggedUser());
      emit(user);
    } catch (e, stackTrace) {
      emit(UserState.error(e as Exception));
    }
  }

  void _onLogout(AuthLogout event, Emitter<UserState> emit) {
    try {
      _authRepository.logout();
      emit(UserState.reset());
    } catch (e, stackTrace) {
      emit(UserState.error(e as Exception));
    }
  }
}
