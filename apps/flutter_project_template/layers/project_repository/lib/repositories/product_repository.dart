import 'package:project_data/entities/product.dart';
import 'package:project_repository/clients/http_client.dart';

class ProductRepository {
  ProductRepository({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  late final HttpClient _httpClient;

  Future<List<Product>> getProducts() async {
    final response = await _httpClient.request(
      path: '/products',
      method: HttpMethod.get,
    );
    return [...response.data["products"].map((e) => Product.fromJson(e))];
  }
}
