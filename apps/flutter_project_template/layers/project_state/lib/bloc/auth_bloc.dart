import 'package:bloc/bloc.dart';
import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_state/events/auth_events.dart';
import 'package:project_state/states/auth_state.dart';

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
