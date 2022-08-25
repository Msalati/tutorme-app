import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:graduation_project/Models/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      print('no user');
      return null;
    } else {
      return User(user.uid, user.email);
    }
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInUser(String email, String password) async {
    final credentail = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(credentail.user);
  }

  Future<User?> createUser(String email, String password) async {
    final credentail = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(credentail.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
