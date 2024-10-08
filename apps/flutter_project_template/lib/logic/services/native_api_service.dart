import 'package:flutter/services.dart';
import 'package:flutter_project_template/core/app/global.dart';

class NativeApiService {
  const NativeApiService() : _methodChannel = const MethodChannel(Constants.methodChannel);

  final MethodChannel _methodChannel;

  Future<String?> getSecureDeviceId() async {
    try {
      return await _methodChannel.invokeMethod('getSecureDeviceId');
    } on Exception catch (e) {
      App.logger.error(e);
      return null;
    }
  }
}
