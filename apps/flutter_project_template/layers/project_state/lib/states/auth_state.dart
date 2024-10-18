import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/repositories/auth_repository.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const UserState._();

  const factory UserState.init([User? user]) = UserStateInit;

  factory UserState.reset([User? user]) => UserStateInit(user);

  const factory UserState.loading() = UserStateLoading;

  const factory UserState.failure(Exception error) = UserStateFailure;

  const factory UserState.success(User user) = UserStateSuccess;
}