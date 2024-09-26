import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:project_common/logger.dart';
import 'package:project_repository/clients/http_client.dart';

class MockRestApiService extends Mock implements RestApiService {}

class RestApiService {
  RestApiService({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  late final HttpClient _httpClient;

  bool _handleError(Function() callback) {
    try {
      callback.call();
      return true;
    } catch (e) {
      logger.exception(e);
      return false;
    }
  }

  bool setBasicAuth(String userName, String password) {
    return _handleError(() {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$userName:$password'))}';
      _httpClient.setHeader('authorization', basicAuth);
    });
  }

  bool setAuthToken(String token) {
    return _handleError(() {
      _httpClient.setHeader('authorization', token);
    });
  }

  bool removeAuth() {
    return _handleError(() {
      _httpClient.setHeader('authorization', null);
    });
  }
}
