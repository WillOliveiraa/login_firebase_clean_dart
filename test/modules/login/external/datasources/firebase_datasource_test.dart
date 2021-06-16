import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/external/datasources/firebase_datasource.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class FirebaseUserMock extends Mock implements User {} // FirebaseUser

class UserCredentialMock extends Mock implements UserCredential {} // AuthResult

class PhoneAuthCredentialMock extends Mock implements PhoneAuthCredential {}

class AuthExceptionMock extends Mock implements FirebaseAuthException {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {
  @override
  Future<void> verifyPhoneNumber({
    String phoneNumber,
    verificationCompleted,
    verificationFailed,
    codeSent,
    codeAutoRetrievalTimeout,
    String autoRetrievedSmsCodeForTesting,
    Duration timeout,
    int forceResendingToken,
  }) async {
    Future.delayed(Duration(milliseconds: 800)).then((value) {
      if (phoneNumber == "0") {
        verificationCompleted(credential);
      } else if (phoneNumber == "1") {
        verificationFailed(authException);
      } else if (phoneNumber == "2") {
        codeSent("dwf32f", 1);
      } else if (phoneNumber == "3") {
        codeAutoRetrievalTimeout("dwf32f");
      }
    });
    return;
  }
}

final credential = PhoneAuthCredentialMock();
final authException = AuthExceptionMock();

main() {
  final auth = FirebaseAuthMock();
  final firebaseUser = FirebaseUserMock();
  final user = UserModel(
    name: "Will Oliveira",
    email: "will@teste.com",
    phoneNumber: "1234567",
  );

  final userCredential = UserCredentialMock();
  final datasource = FirebaseDatasourceImpl(auth);

  setUpAll(() {
    when(firebaseUser.displayName).thenReturn(user.name);
    when(firebaseUser.email).thenReturn(user.email);
    when(firebaseUser.phoneNumber).thenReturn(user.phoneNumber);
    when(userCredential.user).thenReturn(firebaseUser);

    when(auth.signInWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => userCredential);

    when(auth.signInWithCredential(any))
        .thenAnswer((_) async => userCredential);
  });

  test('should return Logged User loginEmail', () async {
    final result = await datasource.loginEmail();

    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });

  test('should return Logged User loginPhone', () async {
    final result = await datasource.loginPhone(phone: "0");

    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });

  test('should return FirebaseUser loginPhone Error', () async {
    expect(() async => await datasource.loginPhone(phone: "1"),
        throwsA(authException));
  });

  test('should return Logged User', () async {
    when(auth.currentUser).thenAnswer((_) => firebaseUser);

    var result = await datasource.currentUser();

    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });

  test('should complete logout', () async {
    when(auth.signOut()).thenAnswer((_) async {});

    expect(datasource.logout(), completes);
  });
}
