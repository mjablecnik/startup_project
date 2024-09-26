import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/repositories/auth_repository.dart';

sealed class State<E, T> {
  const State();
}

class StateInit<E, T> extends State<E, T> {}

class StateLoading<E, T> extends State<E, T> {}

class StateError<E, T> extends State<E, T> {
  const StateError(this.exception);

  final E exception;
}

class StateSuccess<E, T> extends State<E, T> {
  const StateSuccess(this.user);

  final T user;
}

typedef UserState = State<Object, User>;
typedef UserInit = StateInit<Object, User>;
typedef UserLoading = StateLoading<Object, User>;
typedef UserError = StateError<Object, User>;
typedef UserSuccess = StateSuccess<Object, User>;

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
        super(StateInit()) {
    on<AuthShowUser>(_onShowUser);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  late final AuthRepository _authRepository;

  Future<void> _onLogin(AuthLogin event, Emitter<UserState> emit) async {
    try {
      emit(StateLoading());
      final UserSuccess user = StateSuccess(
        await _authRepository.login(
          userName: event.userName,
          password: event.password,
          type: event.type,
        ),
      );
      emit(user);
    } catch (e, stackTrace) {
      emit(StateError(e));
    }
  }

  Future<void> _onShowUser(AuthShowUser event, Emitter<UserState> emit) async {
    try {
      emit(StateLoading());
      final UserSuccess user = StateSuccess(await _authRepository.loggedUser());
      emit(user);
    } catch (e, stackTrace) {
      emit(StateError(e));
    }
  }

  void _onLogout(AuthLogout event, Emitter<UserState> emit) {
    try {
      _authRepository.logout();
      emit(StateInit());
    } catch (e, stackTrace) {
      emit(StateError(e));
    }
  }
}
