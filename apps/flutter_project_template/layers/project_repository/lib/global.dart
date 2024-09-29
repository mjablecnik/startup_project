import 'package:auto_injector/auto_injector.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/clients/secure_storage.dart';
import 'package:project_repository/repositories/auth_repository.dart';
import 'package:project_repository/repositories/product_repository.dart';
import 'package:project_repository/repositories/user_repository.dart';

class MockInjector extends Mock implements AutoInjector {}

AutoInjector repositoryInjector = AutoInjector();

setupInjector({required HttpClient httpClient}) {
  repositoryInjector
    ..addInstance(httpClient)
    ..addSingleton(SecureStorage.new)
    ..addSingleton(AuthRepository.new)
    ..addSingleton(UserRepository.new)
    ..addSingleton(ProductRepository.new)
    ..commit();
}

resetInjector() {
  repositoryInjector = AutoInjector();
}

class StoreKeys {
  static const deviceId = 'deviceId';
  static const loggedUser = 'loggedUser';
}

enum StorageKey { deviceId, loggedUser, themeMode }

class Constants {
  static const methodChannel = 'flutter.app.channel';
}
