import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.sendEmailVerification();

      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}