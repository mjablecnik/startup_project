abstract class BaseEntity {
  const BaseEntity();

  static fromJson(Map<String, Object?> json) {}

  toJson();

  @override
  String toString() {
    return toJson().toString();
  }
}