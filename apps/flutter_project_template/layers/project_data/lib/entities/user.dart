import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_data/entities/base.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User extends BaseEntity with _$User {
  const User._();

  const factory User.initial() = UserInitial;

  const factory User.loading() = UserLoading;

  const factory User.error(exception) = UserError;

  const factory User.notFound() = UserNotFound;

  const factory User.loaded({
    required String firstName,
    required String lastName,
    @JsonKey(name: "username") required String userName,
    @JsonKey(name: "accessToken") String? token,
  }) = UserLoaded;

  String? get fullName {
    if (this is UserLoaded) {
      final user = this as UserLoaded;
      return "${user.firstName} ${user.lastName}";
    }
    return null;
  }

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
