import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaykommerce/models/kayko_user.dart';
import 'package:kaykommerce/services/firestore_service.dart';

import '../locator.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreService = locator<FirestoreService>();

  late KaykoUser _currentUser;
  KaykoUser get currentUser => _currentUser;

  Future loginAnonymously() async {
    try {
      var authResult = await _firebaseAuth.signInAnonymously();

      _currentUser = KaykoUser(authResult.user!.uid);

      await _firestoreService.createUser(_currentUser);

      await _populateCurrentUser(authResult.user!);

      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    if (user != null) await _populateCurrentUser(user);
    return user != null;
  }

  Future<void> _populateCurrentUser(User user) async {
    _currentUser = await _firestoreService.getUser(user.uid);
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
