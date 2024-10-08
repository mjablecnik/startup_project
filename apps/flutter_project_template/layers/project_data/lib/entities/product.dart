import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_data/entities/base.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class Product extends BaseEntity with _$Product {
  const Product._();

  const factory Product({
    required int id,
    required String title,
    required String description,
    required Uri thumbnail,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}

