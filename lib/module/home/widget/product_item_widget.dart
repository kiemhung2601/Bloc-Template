import 'package:flutter/material.dart';

import '../../../core/extension/num_extension.dart';
import '../../../core/widget/widget.dart';
import '../../../data/model/response/product.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
        leading: AppImage(imageURL: product.images.first),
        content: Column(
          children: [
            Text(product.productName),
            const SizedBox(height: 5),
            Text(product.price.toCurrencyFormat),
          ],
        ));
  }
}
