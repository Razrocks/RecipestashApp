import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// with help from:
// https://www.youtube.com/watch?v=VCrXSFqdsoA
// https://www.youtube.com/watch?v=rWamixHIKmQ

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password}) async {
    UserCredential uc = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await uc.user!.updateDisplayName(email.split('@')[0]); // set default display name to be the email address without the domain
  }

  Future<void> signInGoogle() async {
    
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;


    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken
    );

    _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
