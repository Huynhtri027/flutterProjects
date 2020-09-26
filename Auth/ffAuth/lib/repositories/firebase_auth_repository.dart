import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<UserCredential> createWithEmailPassword(
  //     String email, String password) async {
  //   try {
  //     return await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  Future<String> createWithEmailPassword(String name,
      String email, String password,) async {
    
    try {
      final UserCredential _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
        _userCredential.user.updateProfile(displayName: name);
        print(_userCredential.user.displayName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return e.code.toString();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return e.code.toString();
      } else if(e.message != null) {
        print(e);
        print(e.message);
        return e.message.toString();
      }
    }
  }

  Future<String> signInWithEmailPassword(
      String email, String password,) async {
    
    try {
      final UserCredential _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
        print(_userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return e.code.toString();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return e.code.toString();
      } else if(e.message != null) {
        print(e);
        print(e.message);
        return e.message.toString();
      }
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return _firebaseAuth.currentUser.displayName;
  }

  Future<String> getEmail() async {
    return _firebaseAuth.currentUser.email;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
