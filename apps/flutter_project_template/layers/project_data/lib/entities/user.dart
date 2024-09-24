import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required String firstName,
    required String lastName,
    @JsonKey(name: "username") required String userName,
    @JsonKey(name: "accessToken") String? token,
  }) = _User;

  factory User.anonymous() {
    return const User(
      userName: "anonymous",
      lastName: "User",
      firstName: "Anonymous",
    );
  }

  String get fullName => "$firstName $lastName";

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  @override
  String toString() {
    return toJson().toString();
  }
}
