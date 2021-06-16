import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/datasources/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, LoggedUserInfo>> loginEmail(
      {String email, String password}) async {
    try {
      final user =
          await datasource.loginEmail(email: email, password: password);

      return Right(user);
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Error login with Email"));
    }
  }

  @override
  Future<Either<Failure, LoggedUserInfo>> loginPhone({String phone}) async {
    try {
      final user = await datasource.loginPhone(phone: phone);

      return Right(user);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with phone"));
    }
  }

  @override
  Future<Either<Failure, LoggedUserInfo>> loggedUser() async {
    try {
      var user = await datasource.currentUser();

      return Right(user);
    } catch (e) {
      return Left(ErrorGetLoggedUser(
          message: "Error trying to retrieve current logged user"));
    }
  }
}
