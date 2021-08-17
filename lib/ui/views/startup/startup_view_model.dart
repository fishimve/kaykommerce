import 'package:kaykommerce/locator.dart';
import 'package:kaykommerce/routes/route_names.dart';
import 'package:kaykommerce/services/firebase_auth_service.dart';
import 'package:kaykommerce/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends FutureViewModel {
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _navigationService = locator<NavigationService>();
  @override
  Future futureToRun() => handleStartupLogic();

  Future handleStartupLogic() async {
    // await _firebaseAuthService.signout();

    var userHasLoggedIn = await _firebaseAuthService.isUserLoggedIn();

    if (userHasLoggedIn) {
      _navigationService.navigateToWithoutBackOption(BrandsViewRoute);
    } else {
      _navigationService.navigateToWithoutBackOption(OnboardingViewRoute);
    }
  }
}
