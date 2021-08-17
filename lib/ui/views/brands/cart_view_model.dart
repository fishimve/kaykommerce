import 'package:kaykommerce/models/kayko_user.dart';
import 'package:kaykommerce/models/product.dart';
import 'package:kaykommerce/routes/route_names.dart';
import 'package:kaykommerce/services/dialog_service.dart';
import 'package:kaykommerce/services/firebase_auth_service.dart';
import 'package:kaykommerce/services/firestore_service.dart';
import 'package:kaykommerce/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class CartViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _firestoreService = locator<FirestoreService>();

  KaykoUser get _user => _firebaseAuthService.currentUser;

  var _cartItems = <Product>[];
  List<Product> get cartItems => _cartItems;

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((cartItem) {
      total += cartItem.currentPrice * cartItem.quantity;
    });
    return total;
  }

  void listenToCart() {
    setBusy(true);
    _firestoreService.listenToCart(_user.userId).listen((cartData) {
      List<Product>? updatedCartItems = cartData;
      if (updatedCartItems != null && updatedCartItems.length > 0) {
        _cartItems = updatedCartItems;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future<bool> confirmDelete(String prodId) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you want to remove the item from the cart?',
      cancelTitle: 'No',
      confirmationTitle: 'Yes',
    );

    var confirmed = dialogResponse?.confirmed ?? false;
    if (confirmed) {
      setBusy(true);
      await _firestoreService.removeFromCart(_user.userId, prodId);
      setBusy(false);
    }
    return confirmed;
  }

  Future<void> navigateToCart(CartViewModel viewModel) async {
    await _navigationService.navigateTo(CartViewRoute, arguments: viewModel);
  }

  Future<void> placeAnOrder() async {
    setBusy(true);
    await _firestoreService.placeAnOrder(_user.userId, _cartItems, totalAmount);
    await _firestoreService.clearCart(_user.userId);
    setBusy(false);
    await _navigationService.navigateToWithoutBackOption(OrdersViewRoute);
  }
}
