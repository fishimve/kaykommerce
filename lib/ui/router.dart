import 'package:flutter/material.dart';
import 'package:kaykommerce/models/product.dart';
import 'package:kaykommerce/ui/views/brands/cart_view_model.dart';

import '../routes/route_names.dart';
import 'views/brands/brands_view.dart';
import 'views/brands/cart_view.dart';
import 'views/onboarding/onboarding_view.dart';
import 'views/orders/orders_view.dart';
import 'views/product_details/product_details_view.dart';
import 'views/products/products_view.dart';

PageRoute _getPageRoute({
  required String? routeName,
  required Widget viewToShow,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: OnboardingView(),
      );
    case BrandsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: BrandsView(),
      );
    case ProductsViewRoute:
      var category = settings.arguments as Map<String, String>;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductsView(
          categoryId: category['id']!,
          categoryName: category['name']!,
        ),
      );
    case ProductDetailsViewRoute:
      var product = settings.arguments as Product;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductDetailsView(
          product: product,
        ),
      );
    case CartViewRoute:
      var viewModel = settings.arguments as CartViewModel;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CartView(viewModel: viewModel),
      );
    case OrdersViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: OrdersView(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
