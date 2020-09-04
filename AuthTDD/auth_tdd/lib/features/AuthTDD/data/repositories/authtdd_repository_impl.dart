import 'package:auth_tdd/core/error/failures.dart';
import 'package:auth_tdd/features/AuthTDD/domain/entities/authtdd.dart';
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
  Future<Either<Failures, AuthUser>> getFirebaseAuth() async {
    signInWithGoogle();
    print(getUser());
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser;
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

  Future<void> getUser() async {
    //return (await _firebaseAuth.currentUser).email;
    print(_firebaseAuth.currentUser.email);
  }
}