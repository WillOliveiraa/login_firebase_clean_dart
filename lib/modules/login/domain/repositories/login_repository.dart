import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoggedUserInfo>> loginEmail(
      {String email, String password});

  Future<Either<Failure, LoggedUserInfo>> loginPhone({String phone});

  Future<Either<Failure, LoggedUserInfo>> loggedUser();

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, LoggedUserInfo>> verifyPhoneCode(
      {String verificationId, String code});
}
