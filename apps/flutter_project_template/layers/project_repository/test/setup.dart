import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

setupData(Function() setupFakeData, {required bool useFakeData}) {
  final apiUrl = "https://dummyjson.com";
  if (useFakeData) {
    print('Using fake data..');
    setupFakeData();
  } else {
    print('Using real data from: $apiUrl');
    setupInjector(
      httpClient: HttpClient(
        apiUrl: apiUrl,
        enableLogs: true,
        preventLargeResponses: false,
      ),
    );
  }
}
