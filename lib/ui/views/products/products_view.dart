import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/views/products/products_view_model.dart';
import 'package:kaykommerce/ui/widgets/product_widget.dart';
import 'package:stacked/stacked.dart';

class ProductsView extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  const ProductsView({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.getBrandsCategories(categoryId),
      builder: (context, viewModel, child) {
        var products = viewModel.brandProducts;
        var addToCart = viewModel.addProductToCart;
        return Scaffold(
          appBar: AppBar(
            title: Text(categoryName),
          ),
          body: viewModel.isBusy
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => ProductWidget(
                    addToCart: addToCart,
                    product: products[index],
                    navigateToDetails: () =>
                        viewModel.navigateToProductDetails(index),
                  ),
                ),
        );
      },
      viewModelBuilder: () => ProductsViewModel(),
    );
  }
}
