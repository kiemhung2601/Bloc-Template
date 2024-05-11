import 'package:injectable/injectable.dart';

import '../model/response/product.dart';
import 'base_repository.dart';

@Singleton(order: -1)
class HomeRepository extends BaseRepository {
  const HomeRepository() : super('/api/v1/sales');

  Future<ProductPage?> loadProduct(int idCategory) => apiService.putJson(
        '$path/product-ec/categoryOrName',
        data: {
          'category': idCategory,
          'name': '',
        },
        converter: (data) => ProductPage.fromJson(data),
      );
}
