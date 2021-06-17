import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/verify_phone_code.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

main() {
  final repository = LoginRepositoryMock();
  final usecase = VerifyPhoneCodeImpl(repository);

  test("should verify if code is not valid", () async {
    var result = await usecase(
        LoginCredential.withVerificationCode(code: "", verificationId: ""));

    expect(result.leftMap((l) => l is ErrorVerifyPhoneCode), Left(true));
  });

  test("should verify if verificationId is not valid", () async {
    var result = await usecase(
        LoginCredential.withVerificationCode(code: "1234", verificationId: ""));

    expect(result.leftMap((l) => l is ErrorVerifyPhoneCode), Left(true));
  });

  test("should consume repository verifyPhoneCode", () async {
    var user = UserModel(name: "name");

    when(repository.verifyPhoneCode(
            code: anyNamed("code"), verificationId: anyNamed("verificationId")))
        .thenAnswer((_) async => Right(user));

    var result = await usecase(LoginCredential.withVerificationCode(
        code: "1234", verificationId: "123123"));

    expect(result, Right(user));
  });
}
