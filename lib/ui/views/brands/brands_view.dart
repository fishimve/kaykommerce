import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/shared/app_colors.dart';
import 'package:kaykommerce/ui/views/brands/brands_view_model.dart';
import 'package:kaykommerce/ui/views/brands/cart_view_model.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';
import 'package:stacked/stacked.dart';

class BrandsView extends StatelessWidget {
  const BrandsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BrandsViewModel>.reactive(
      viewModelBuilder: () => BrandsViewModel(),
      onModelReady: (viewModel) => viewModel.getBrandsCategories(),
      builder: (context, viewModel, child) {
        var brands = viewModel.brandCategories;
        return Scaffold(
          appBar: AppBar(
            title: Text('Brands Categories'),
            actions: [
              ViewModelBuilder<CartViewModel>.reactive(
                viewModelBuilder: () => CartViewModel(),
                onModelReady: (model) => model.listenToCart(),
                builder: (context, model, child) => model.isBusy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : BadgeWidget(
                        child: IconButton(
                          onPressed: () => model.navigateToCart(model),
                          icon: Icon(Icons.shopping_cart),
                        ),
                        value: model.cartItems.length.toString(),
                      ),
              ),
              IconButton(
                onPressed: viewModel.navigateToOrders,
                icon: Icon(Icons.history),
              ),
            ],
          ),
          body: viewModel.isBusy
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    var brand = brands[index];
                    return ExpansionTile(
                      title: KaykoText.headingThree(brand.title),
                      iconColor: kcPrimaryColor,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                      childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      expandedAlignment: Alignment.centerLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: brand.brands.map((br) {
                        var brTitle = br.title;
                        return GestureDetector(
                          onTap: () => viewModel.navigateToBrandProducts(
                            index,
                            brand.brands.indexOf(br),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: KaykoText.subheading(brTitle),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
        );
      },
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final Widget child;
  final String value;
  const BadgeWidget({
    Key? key,
    required this.child,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.redAccent,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              maxHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
