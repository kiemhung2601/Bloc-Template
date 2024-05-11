import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/base/model/base_page_response.dart';

part 'product.freezed.dart';
part 'product.g.dart';

class ProductPage extends BasePageResponse<Product> {
  const ProductPage({
    super.page,
    super.totalValue,
  });

  factory ProductPage.fromJson(Json json) {
    final response = BasePageResponse.fromJson(
      json,
      fromJson: Product.fromJson,
    );

    return ProductPage(page: response.page, totalValue: response.totalValue);
  }

  Json toJson() => toJsonBase((data) => data.toJson());
}

@freezed
class Product with _$Product {
  const factory Product({
    @Default([]) List<String?> images,
    @Default(.0) double price, // Giá bán
    @Default('') String productName, // Tên sản phẩm
  }) = _Product;

  // To JSON
  const Product._();

  // From JSON
  factory Product.fromJson(Json json) => _$ProductFromJson(json);
}
