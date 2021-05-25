import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_email.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

main() {
  final repository = LoginRepositoryMock();
  final usecase = LoginWithEmailImpl(repository);

  test('should verify if email is not valid', () async {
    final result = await usecase(
        LoginCredential.withEmailAndPassword(email: "", password: ""));

    expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
  });

  test('should verify if password is not valid', () async {
    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "will@teste.com", password: ""));

    expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
  });

  // test('should consume repository loginEmail', () async {
  //   final result = await usecase();
  // });
}
