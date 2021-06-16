import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_phone.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

main() {
  final repository = LoginRepositoryMock();
  final usecase = LoginWithPhoneImpl(repository);

  test("should verify if phone is not valid", () async {
    var result = await usecase(LoginCredential.withPhone(phoneNumber: ""));

    expect(result.leftMap((l) => l is ErrorLoginPhone), Left(true));
  });

  test("should consume repository loginPhone but not automatic retrieve",
      () async {
    var error = ErrorLoginPhone();
    when(repository.loginPhone(phone: anyNamed('phone')))
        .thenAnswer((_) async => Left(error));

    var result =
        await usecase(LoginCredential.withPhone(phoneNumber: "12345678901234"));

    expect(result, Left(error));
  });

  test("should consume repository loginPhone", () async {
    var user = UserModel(name: "null");
    when(repository.loginPhone(phone: anyNamed('phone')))
        .thenAnswer((_) async => Right(user));

    var result =
        await usecase(LoginCredential.withPhone(phoneNumber: "+5544997607227"));

    expect(result, Right(user));
  });
}
