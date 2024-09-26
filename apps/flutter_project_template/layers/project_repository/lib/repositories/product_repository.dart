import 'package:project_data/entities/product.dart';
import 'package:project_repository/clients/http_client.dart';

class ProductRepository {
  ProductRepository({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  late final HttpClient _httpClient;

  Future<List<Product>> getProducts() async {
    return _httpClient.createRequest(
      () => _httpClient.get('/products'),
      (data) async => [...data["products"].map((e) => Product.fromJson(e))],
    );
  }
}
