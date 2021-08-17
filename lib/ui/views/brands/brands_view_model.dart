import 'package:kaykommerce/locator.dart';
import 'package:kaykommerce/models/brand.dart';
import 'package:kaykommerce/routes/route_names.dart';
import 'package:kaykommerce/services/api_service.dart';
import 'package:kaykommerce/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class BrandsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  var _api = locator<ApiService>();

  List<BrandCategory> _brandCategories = [];
  List<BrandCategory> get brandCategories => _brandCategories;

  Future<void> getBrandsCategories() async {
    setBusy(true);
    _brandCategories = await _api.getBrands();
    setBusy(false);
  }

  void navigateToBrandProducts(int brandCatIndex, int brandIndex) async {
    await _navigationService.navigateTo(ProductsViewRoute, arguments: {
      'id': _brandCategories[brandCatIndex].brands[brandIndex].id,
      'name': _brandCategories[brandCatIndex].brands[brandIndex].title,
    });
  }

  void navigateToOrders() async {
    await _navigationService.navigateTo(OrdersViewRoute);
  }
}
