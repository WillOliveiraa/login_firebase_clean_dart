import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/datasources/login_datasource.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:mockito/mockito.dart';

class LoginDatasourceMock extends Mock implements LoginDatasource {}

main() {
  final datasource = LoginDatasourceMock();
  final repository = LoginRepositoryImpl(datasource);
  final userReturn = UserModel(
    name: "Will Oliveira",
    email: "will@teste.com",
    phoneNumber: "1234567",
  );

  group("loginEmail", () {
    test('should get UserModel', () async {
      when(datasource.loginEmail()).thenAnswer((_) async => userReturn);

      final result = await repository.loginEmail();

      expect(result, isA<Right<dynamic, LoggedUserInfo>>());
    });

    test('should call ErrorLoginEmail', () async {
      when(datasource.loginEmail()).thenThrow(ErrorLoginEmail());

      final result = await repository.loginEmail();

      expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
    });

    group("loginPhone", () {
      test('should get UserModel', () async {
        when(datasource.loginPhone(phone: anyNamed('phone')))
            .thenAnswer((_) async => userReturn);

        final result = await repository.loginPhone();

        expect(result, isA<Right<dynamic, LoggedUserInfo>>());
      });
      test('should call ErrorLoginPhone', () async {
        when(datasource.loginPhone(phone: anyNamed('phone')))
            .thenThrow(ErrorLoginPhone());

        final result = await repository.loginPhone();

        expect(result.leftMap((l) => l is ErrorLoginPhone), Left(true));
      });
    });
  });

  group("loggedUser", () {
    test('should get Current User Logged', () async {
      when(datasource.currentUser()).thenAnswer((_) async => userReturn);

      var result = await repository.loggedUser();

      expect(result, isA<Right<dynamic, LoggedUserInfo>>());
    });

    test('should Throw when user not logged', () async {
      when(datasource.currentUser()).thenThrow(ErrorGetLoggedUser());

      var result = await repository.loggedUser();

      expect(result.leftMap((l) => l is ErrorGetLoggedUser), Left(true));
    });
  });

  group("logout", () {
    test('should get logout', () async {
      when(datasource.logout()).thenAnswer((_) async {});

      var result = await repository.logout();

      expect(result, isA<Right<dynamic, Unit>>());
    });

    test('should Throw when user try logout', () async {
      when(datasource.logout()).thenThrow(ErrorLogout());

      var result = await repository.logout();

      expect(result.leftMap((l) => l is ErrorLogout), Left(true));
    });
  });
}
