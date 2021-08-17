import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/shared/app_colors.dart';
import 'package:kaykommerce/ui/views/brands/cart_view_model.dart';
import 'package:kaykommerce/ui/widgets/image_widget.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';

class CartView extends StatelessWidget {
  final CartViewModel viewModel;
  const CartView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KaykoText.subheading('Total'),
                  Spacer(),
                  Chip(
                    label: KaykoText.body(
                      '${viewModel.totalAmount.toStringAsFixed(2)} USD',
                    ),
                    backgroundColor: kcLightGreyColor,
                  ),
                  SizedBox(width: 5),
                  TextButton(
                    child: Text('ORDER NOW'),
                    onPressed: viewModel.placeAnOrder,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.cartItems.length,
              itemBuilder: (context, index) {
                var product = viewModel.cartItems[index];
                return Dismissible(
                  key: ValueKey(product.id),
                  background: Container(
                    color: Colors.redAccent,
                    child: Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) => viewModel.confirmDelete(product.id),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: ImageWidget(
                          imageUrl: product.imageUrl,
                        ),
                        title: KaykoText.body(product.name),
                        subtitle: KaykoText.caption(
                          'Total: ${product.currentPrice * product.quantity}',
                        ),
                        trailing: Text('${product.quantity} x'),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
