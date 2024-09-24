import 'package:android_device_id_generator/android_device_id_generator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mocktail/mocktail.dart';

class MockAppInfo extends Mock implements AppInfo {}

class AppInfo {
  late final bool isLoaded;
  late final String deviceId;
  late final String appVersion;
  late final String appName;


  AppInfo() {
    loadData().then((value) => isLoaded = value);
  }

  Future<bool> loadData() async {
    deviceId = await _getDeviceId();
    appVersion = (await PackageInfo.fromPlatform()).version;
    appName = (await PackageInfo.fromPlatform()).appName;
    return true;
  }

  _getDeviceId() async {
    final storage = FlutterSecureStorage();
    
    String? deviceId = await storage.read(key: 'deviceId');

    if (deviceId == null) {
      deviceId = await MobileDeviceIdentifier().getDeviceId();
      deviceId ??= generateAndroidDeviceId(secure: true);

      storage.write(key: 'deviceId', value: deviceId);
    }

    return deviceId;
  }
}
