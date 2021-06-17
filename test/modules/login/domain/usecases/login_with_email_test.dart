import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/services/connectivity_service.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_email.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class ConnectivityServiceMock extends Mock implements ConnectivityService {}

main() {
  final repository = LoginRepositoryMock();
  final service = ConnectivityServiceMock();
  final usecase = LoginWithEmailImpl(repository, service);

  setUpAll(() {
    when(service.isOnline()).thenAnswer((_) async => Right(unit));
  });

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

  test('should consume repository loginEmail', () async {
    var user = UserModel(name: "name");
    when(repository.loginEmail(
            email: anyNamed("email"), password: anyNamed("password")))
        .thenAnswer((_) async => Right(user));

    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "will@teste.com", password: "123123"));

    expect(result, Right(user));
  });

  test('should return error when offline', () async {
    when(service.isOnline())
        .thenAnswer((realInvocation) async => Left(ConnectionError()));

    final result = await usecase(LoginCredential.withEmailAndPassword(
        email: "will@teste.com", password: "123123"));

    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
