import 'package:flutter/services.dart';
import 'package:project_common/logger.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

abstract class Repository {
  const Repository({required this.httpClient}) : methodChannel = const MethodChannel(Constants.methodChannel);

  final HttpClient httpClient;

  final MethodChannel methodChannel;

  // Example of MethodChannel usage
  Future<String?> getSecureDeviceId() async {
    try {
      return await methodChannel.invokeMethod('getSecureDeviceId');
    } on Exception catch (e) {
      logger.exception(e);
      return null;
    }
  }
}
