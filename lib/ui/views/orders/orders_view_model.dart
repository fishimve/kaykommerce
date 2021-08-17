import 'package:kaykommerce/models/kayko_user.dart';
import 'package:kaykommerce/models/order.dart';
import 'package:kaykommerce/services/firebase_auth_service.dart';
import 'package:kaykommerce/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class OrdersViewModel extends BaseViewModel {
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _firestoreService = locator<FirestoreService>();

  KaykoUser get _user => _firebaseAuthService.currentUser;

  var _userOrders = <Order>[];
  List<Order> get userOrders => _userOrders;

  Future<void> getUserOrder() async {
    setBusy(true);
    _userOrders = await _firestoreService.getOrders(_user.userId);
    setBusy(false);
  }
}
