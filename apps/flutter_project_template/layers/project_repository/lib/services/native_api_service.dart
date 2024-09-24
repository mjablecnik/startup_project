import 'package:flutter/services.dart';
import 'package:project_common/logger.dart';
import 'package:project_repository/global.dart';

class NativeApiService {
  const NativeApiService() : _methodChannel = const MethodChannel(Constants.methodChannel);

  final MethodChannel _methodChannel;

  Future<String?> getSecureDeviceId() async {
    try {
      return await _methodChannel.invokeMethod('getSecureDeviceId');
    } on Exception catch (e) {
      logger.exception(e);
      return null;
    }
  }
}