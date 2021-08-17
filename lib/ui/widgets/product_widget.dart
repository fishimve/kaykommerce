import 'package:flutter/material.dart';
import 'package:kaykommerce/models/product.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';

import 'image_widget.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final VoidCallback navigateToDetails;
  final Function addToCart;
  const ProductWidget({
    Key? key,
    required this.product,
    required this.navigateToDetails,
    required this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: navigateToDetails,
          child: ImageWidget(imageUrl: product.imageUrl),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: KaykoText.body(product.name),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              await addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      // remove item
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
