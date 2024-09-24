import 'package:dio/dio.dart';
import 'package:project_data/entities/product.dart';
import 'package:project_repository/clients/http_client.dart';

class ProductRepository {
  ProductRepository({required HttpClient httpClient}) {
    _api = httpClient;
    _client = httpClient.dio;
  }

  late final Dio _client;
  late final HttpClient _api;

  Future<List<Product>> getProducts() async {
    return _api.createRequest(
      () => _client.get('/products'),
      (data) async => [...data["products"].map((e) => Product.fromJson(e))],
    );
  }
}
