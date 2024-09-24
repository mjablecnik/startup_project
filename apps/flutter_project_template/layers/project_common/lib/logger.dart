import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final logger = Logger.get;

class Logger {
  late final Talker _talker;

  static final Logger _instance = Logger._internal();

  Logger._internal() {
    _talker = Talker(
      settings: TalkerSettings(
        useHistory: false,
        useConsoleLogs: true,
        enabled: true,
      ),
    );
  }

  static Logger get get => _instance;

  void debug(String msg, {Object? exception, StackTrace? stackTrace}) {
    return _talker.debug(msg, exception, stackTrace);
  }

  void info(String msg, {Object? exception, StackTrace? stackTrace}) {
    return _talker.info(msg, exception, stackTrace);
  }

  void warning(String msg, {Object? exception, StackTrace? stackTrace}) {
    return _talker.warning(msg, exception, stackTrace);
  }

  void error(String msg, {Object? exception, StackTrace? stackTrace}) {
    return _talker.error(msg, exception, stackTrace);
  }

  void critical(String msg, {Object? exception, StackTrace? stackTrace}) {
    return _talker.critical(msg, exception, stackTrace);
  }

  void exception(Object exception, {StackTrace? stackTrace}) {
    return _talker.handle(exception, stackTrace);
  }

  static TalkerDioLogger dioInterceptor({bool preventLargeResponses = true}) {
    return TalkerDioLogger(
      talker: Logger.get._talker,
      settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printRequestData: true,
        printResponseHeaders: false,
        printResponseMessage: true,
        responseFilter: (response) {
          if (preventLargeResponses) {
            return response.data.toString().length <= 500;
          } else {
            return true;
          }
        },
      ),
    );
  }
}

