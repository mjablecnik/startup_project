import 'package:flutter/services.dart';
import 'package:project_repository/global.dart';
import 'package:talker/talker.dart';

class NativeApiService {
  const NativeApiService({required this.logger}) : _methodChannel = const MethodChannel(Constants.methodChannel);

  final MethodChannel _methodChannel;
  final Talker logger;

  Future<String?> getSecureDeviceId() async {
    try {
      return await _methodChannel.invokeMethod('getSecureDeviceId');
    } on Exception catch (e) {
      logger.error(e);
      return null;
    }
  }
}
