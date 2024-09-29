import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/repositories/auth_repository.dart';

part 'auth3_bloc.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const UserState._();

  const factory UserState.init([User? user]) = UserStateInit;

  factory UserState.reset([User? user]) => UserStateInit(user);

  const factory UserState.loading() = UserStateLoading;

  const factory UserState.failure(Exception error) = UserStateFailure;

  const factory UserState.success(User user) = UserStateSuccess;
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
      emit(UserState.failure(e as Exception));
    }
  }

  Future<void> _onShowUser(AuthShowUser event, Emitter<UserState> emit) async {
    try {
      emit(UserState.loading());
      final UserState user = UserState.success(await _authRepository.loggedUser());
      emit(user);
    } catch (e, stackTrace) {
      emit(UserState.failure(e as Exception));
    }
  }

  void _onLogout(AuthLogout event, Emitter<UserState> emit) {
    try {
      _authRepository.logout();
      emit(UserState.reset());
    } catch (e, stackTrace) {
      emit(UserState.failure(e as Exception));
    }
  }
}
