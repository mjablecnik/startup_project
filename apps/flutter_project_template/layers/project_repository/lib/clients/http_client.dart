import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_repository/exceptions.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HttpClient {
  late final Dio dio;
  final Talker logger;

  final String apiUrl;
  final bool enableLogs;
  final bool preventLargeResponses;

  HttpClient({
    required this.logger,
    required this.apiUrl,
    required this.enableLogs,
    required this.preventLargeResponses,
  }) {
    //logger.log('DeviceId: ${cached.deviceId}');
    dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (enableLogs) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: logger,
          settings: TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseHeaders: false,
            printResponseMessage: true,
            responseFilter: (Response response) {
              if (preventLargeResponses) {
                return response.data.toString().length <= 500;
              } else {
                return true;
              }
            },
          ),
        ),
      );
    }
  }

  Future<T> createRequest<T>(
    Future<Response> Function() request,
    Future<T> Function(dynamic data) parseData, {
    Future<ServerException?> Function(int? status, dynamic data)? onServerError,
  }) async {
    try {
      final response = await request.call();
      if (response.statusCode == 200 && response.data != null) {
        try {
          return await parseData(response.data);
        } on Error catch (error) {
          logger.error(error);
          logger.handle(error.stackTrace.toString());
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
            logger.error(error);
            logger.handle(error.stackTrace.toString());
          }
        }
        throw ServerException(
          message: "DioException response status code: ${e.response?.statusCode}",
        );
      }
    }
  }
}
