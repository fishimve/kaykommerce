import 'package:flutter/material.dart';
import 'package:kaykommerce/models/product.dart';
import 'package:kaykommerce/ui/widgets/image_widget.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;
  const ProductDetailsView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KaykoText.headingTwo(product.name),
            SizedBox(height: 10),
            KaykoText.body('Brand: ${product.brandName}'),
            SizedBox(height: 10),
            KaykoText.caption('Price in USD: \$${product.currentPrice}'),
            SizedBox(height: 10),
            Expanded(child: ImageWidget(imageUrl: product.imageUrl)),
          ],
        ),
      ),
    );
  }
}
