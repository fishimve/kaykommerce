import 'package:kaykommerce/models/kayko_user.dart';
import 'package:kaykommerce/models/product.dart';
import 'package:kaykommerce/routes/route_names.dart';
import 'package:kaykommerce/services/api_service.dart';
import 'package:kaykommerce/services/firebase_auth_service.dart';
import 'package:kaykommerce/services/firestore_service.dart';
import 'package:kaykommerce/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class ProductsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _firestoreService = locator<FirestoreService>();

  var _api = locator<ApiService>();

  List<Product> _brandProducts = [];
  List<Product> get brandProducts => _brandProducts;

  KaykoUser get _user => _firebaseAuthService.currentUser;

  Future<void> addProductToCart(Product product) async {
    setBusy(true);
    await _firestoreService.addProductToCart(_user.userId, product);
    setBusy(false);
  }

  Future<void> getBrandsCategories(String categoryId) async {
    setBusy(true);
    _brandProducts = await _api.getProductsList(categoryId);
    setBusy(false);
  }

  void navigateToProductDetails(int prodIndexx) async {
    await _navigationService.navigateTo(
      ProductDetailsViewRoute,
      arguments: _brandProducts[prodIndexx],
    );
  }
}
