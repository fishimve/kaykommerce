import 'package:get_it/get_it.dart';
import 'services/api_service.dart';
import 'services/dialog_service.dart';
import 'services/firebase_auth_service.dart';
import 'services/firestore_service.dart';
import 'services/navigation_service.dart';

var locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => ApiService());
}
