import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/external/datasources/firebase_datasource.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class FirebaseUserMock extends Mock implements User {} // FirebaseUser

class UserCredentialMock extends Mock implements UserCredential {} // AuthResult

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

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
}
