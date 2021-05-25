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
  });
}
