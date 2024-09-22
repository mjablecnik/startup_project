class MissingOptionException implements Exception {
  final String message;

  const MissingOptionException({required this.message});
}
