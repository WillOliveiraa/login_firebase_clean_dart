import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/get_logged_user.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class FirebaseUserMock extends Mock implements User {}

main() {
  final repository = LoginRepositoryMock();
  final usecase = GetLoggedUserImpl(repository);

  test("should verify if exist User logged", () async {
    when(repository.loggedUser()).thenAnswer(
        (_) async => Right(UserModel(name: "", email: "", phoneNumber: "")));

    var result = (await usecase()).fold((l) => null, (r) => r);

    expect(result, isA<LoggedUserInfo>());
  });

  test("should return null if user not logged", () async {
    when(repository.loggedUser())
        .thenAnswer((_) async => Left(ErrorGetLoggedUser()));

    var result = (await usecase()).fold((l) => null, (r) => r);

    expect(result, null);
  });
}
