class ServerException implements Exception {
  final String? message;

  ServerException({this.message});

  @override
  String toString() {
    return 'ServerException: $message';
  }

  // void showPopup(BuildContext context) {
  //   final error = t.errors[runtimeType.toString()]!;
  //   Popup.showErrorPage(
  //     context: context,
  //     title: error.title,
  //     message: error.message,
  //     errorDetails: "Test error detail\nNext detail"
  //   );
  // }
}

class ParseDataException extends ServerException {
  final String? message;

  ParseDataException({this.message});
}

class AccessDeniedException extends ServerException {}

class InternetConnectionException extends ServerException {}
