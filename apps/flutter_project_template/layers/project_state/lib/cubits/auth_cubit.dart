import 'package:bloc/bloc.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/repositories/auth_repository.dart';

class AuthCubit extends Cubit<User?> {
  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(null);

  late final AuthRepository _authRepository;

  update(User? state) {
    emit(state);
  }

  get loggedUser => state;

  login({
    required String userName,
    required String password,
    required LoginType type,
    required Function(User) onSuccess,
    required Function(Object, StackTrace) onFailure,
  }) async {
    try {
      final User user = await _authRepository.login(userName: userName, password: password, type: type);
      update(user);
      onSuccess(user);
    } catch (e, stackTrace) {
      onFailure(e, stackTrace);
    }
  }

  Future<User?> getLoggedUser() async {
    try {
      final User? user = await _authRepository.loggedUser();
      if (user != null) update(user);
      return user;
    } catch (e) {
      return null;
    }
  }

  bool logout() {
    update(null);
    return _authRepository.logout();
  }
}
