import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_data/entities/product.dart';
import 'package:project_repository/repositories/product_repository.dart';

class ProductListCubit extends Cubit<List<Product>?> {
  ProductListCubit({required ProductRepository restApiService}) : super(null) {
    _restApiService = restApiService;
    init();
  }

  late final ProductRepository _restApiService;

  update(List<Product>? state) {
    emit(state);
  }

  init() => reload();

  Future<void> reload() async {
    try {
      update(await _restApiService.getProducts());
    } catch (e) {
      update(null);
    }
  }
}
