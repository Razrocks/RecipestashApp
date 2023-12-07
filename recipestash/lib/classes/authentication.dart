// Import necessary packages for authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Authentication class responsible for handling user authentication
class Authentication {
  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter for retrieving the current authenticated user
  User? get currentUser => _auth.currentUser;

  // Stream to listen for changes in authentication state
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Method to sign in with email and password
  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Method to sign up with email and password
  Future<void> signUp({required String email, required String password}) async {
    // Create a new user and set default display name based on email address
    UserCredential uc = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await uc.user!.updateDisplayName(email.split('@')[0]);
  }

  // Method to sign in with Google account
  Future<void> signInGoogle() async {
    // Use GoogleSignIn to initiate Google sign-in
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create authentication credentials using Google sign-in data
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

    // Sign in with the obtained credentials
    _auth.signInWithCredential(credential);
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    // Sign out from Google and Firebase authentication
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
