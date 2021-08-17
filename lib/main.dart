import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaykommerce/ui/shared/app_colors.dart';

import 'locator.dart';
import 'services/dialog_service.dart';
import 'services/navigation_service.dart';
import 'ui/router.dart';
import 'ui/views/startup/startup_view.dart';
import 'utils/dialog_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kayko Kommerce',
      theme: ThemeData(
        primaryColor: kcPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: generateRoute,
      home: StartupView(),
    );
  }
}
