import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_common/logger.dart';
import 'package:project_repository/exceptions.dart';

enum HttpMethod { get, post, put, delete, head, options, patch }

class HttpClient {
  late final Dio _dio;

  final String apiUrl;
  final bool enableLogs;
  final bool preventLargeResponses;

  HttpClient({
    required this.apiUrl,
    required this.enableLogs,
    required this.preventLargeResponses,
  }) {
    //logger.log('DeviceId: ${cached.deviceId}');
    _dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (enableLogs) {
      _dio.interceptors.add(
        Logger.dioInterceptor(
          preventLargeResponses: preventLargeResponses,
        ),
      );
    }
    /*
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      error: true,
    ));
    */
  }

  setHeader(String key, String? value) {
    if (value == null) {
      if (_dio.options.headers.containsKey('authorization')) {
        _dio.options.headers.remove('authorization');
      }
    }
    _dio.options.headers[key] = value;
  }

  setHeaders(Map<String, String> map) {
    _dio.options.headers = {...map};
  }

  Future<T> request<T>({
    required String path,
    required HttpMethod method,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required Future<T> Function(dynamic data) onSuccess,
    Future<ServerException?> Function(int? status, dynamic data)? onServerError,
  }) {
    final options = Options(headers: headers, method: method.name.toUpperCase());
    return _createRequest(
      () => _dio.request(path, data: data, queryParameters: queryParameters, options: options),
      onSuccess: onSuccess,
      onServerError: onServerError,
    );
  }

  Future<T> _createRequest<T>(
    Future<Response> Function() request, {
    required Future<T> Function(dynamic data) onSuccess,
    Future<ServerException?> Function(int? status, dynamic data)? onServerError,
  }) async {
    try {
      final response = await request.call();
      if (response.statusCode == 200 && response.data != null) {
        try {
          return await onSuccess(response.data);
        } on Error catch (error) {
          logger.exception(error, stackTrace: error.stackTrace);
          throw ParseDataException();
        }
      }
      throw ServerException();
    } on DioException catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) throw InternetConnectionException();

      if (e.response?.statusCode == 403) {
        throw AccessDeniedException();
      } else {
        if (onServerError != null && e.response != null) {
          try {
            final error = await onServerError.call(e.response?.statusCode, e.response?.data);
            if (error != null) throw error;
          } on Error catch (error) {
            logger.exception(error, stackTrace: error.stackTrace);
          }
        }
        throw ServerException(
          message: "DioException response status code: ${e.response?.statusCode}",
        );
      }
    }
  }
}
