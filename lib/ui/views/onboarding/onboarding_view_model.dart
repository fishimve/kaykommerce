import 'package:kaykommerce/locator.dart';
import 'package:kaykommerce/routes/route_names.dart';
import 'package:kaykommerce/services/dialog_service.dart';
import 'package:kaykommerce/services/firebase_auth_service.dart';
import 'package:kaykommerce/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _dialogService = locator<DialogService>();

  Future<void> login() async {
    setBusy(true);
    var result = await _firebaseAuthService.loginAnonymously();
    if (result) {
      _navigationService.navigateToWithoutBackOption(BrandsViewRoute);
    } else if (!result) {
      await _dialogService.showDialog(
        title: 'Login Failed!',
        description: 'Please try again later',
        buttonTitle: 'Ok',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Login Failed!',
        description: result,
        buttonTitle: 'Ok',
      );
    }
    setBusy(false);
  }
}
