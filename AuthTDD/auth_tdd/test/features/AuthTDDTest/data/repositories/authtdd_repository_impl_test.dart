import 'package:auth_tdd/features/AuthTDD/data/repositories/authtdd_repository_impl.dart';
import 'package:auth_tdd/features/AuthTDD/domain/repositories/authtdd_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockAuthTDDRepositoryImpl extends Mock implements AuthTDDRepository {}

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  //final MockAuthTDDRepositoryImpl mockAuthTDDRepositoryImpl = MockAuthTDDRepositoryImpl();
  
  AuthTDDRepositoryImpl authTDDRepositoryImpl;
  MockGoogleSignIn mockGoogleSignIn;
  MockFirebaseAuth mockFirebaseAuth;
  setUp(() {
    authTDDRepositoryImpl = AuthTDDRepositoryImpl(firebaseAuth: mockFirebaseAuth);
    mockFirebaseAuth = MockFirebaseAuth();
  });
  tearDown(() {});

  test("emit occurs", () async {
    expectLater(authTDDRepositoryImpl.getUser(), emitsInOrder([_mockUser]));
  });

  // group('getFirebaseAuth', () {
  //   //when(authTDDRepositoryImpl.getFirebaseAuth().)
  //   expectLater(mockGoogleSignIn.currentUser, emitsInOrder([_mockUser]));
  // });
}
