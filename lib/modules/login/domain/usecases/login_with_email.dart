import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithEmail {
  Future<Either<Failure, LoggedUserInfo>> call(LoginCredential credential);
}

class LoginWithEmailImpl implements LoginWithEmail {
  final LoginRepository repository;

  LoginWithEmailImpl(this.repository);

  @override
  Future<Either<Failure, LoggedUserInfo>> call(
      LoginCredential credential) async {
    if (!credential.isValidEmail) {
      return Left(ErrorLoginEmail(message: "Invalid Email"));
    } else if (!credential.isValidPassword) {
      return Left(ErrorLoginEmail(message: "Invalid Password"));
    }

    return await repository.loginEmail(
      email: credential.email,
      password: credential.password,
    );
  }
}
