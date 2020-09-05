import 'package:auth_tdd/core/error/failures.dart';
import 'package:auth_tdd/features/AuthTDD/domain/repositories/authtdd_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthTDDRepositoryImpl implements AuthTDDRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthTDDRepositoryImpl({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
   : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _googleSignIn = googleSignIn ?? GoogleSignIn();
  
  @override
  Future<Either<Failures, User>> getFirebaseAuth() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return Right(_firebaseAuth.currentUser);
    // final UserCredential user = (await _firebaseAuth.signInWithCredential(credential));
    // return Right(_firebaseAuth.currentUser);
    //print(getUser());
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    print(_firebaseAuth.currentUser.email);
    return (await _firebaseAuth.currentUser).email;
    
  }
}