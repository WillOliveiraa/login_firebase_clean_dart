import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/services/connectivity_service.dart';

abstract class LoginWithPhone {
  Future<Either<Failure, LoggedUserInfo>> call(LoginCredential credential);
}

class LoginWithPhoneImpl implements LoginWithPhone {
  final LoginRepository repository;
  final ConnectivityService service;

  LoginWithPhoneImpl(this.repository, this.service);

  @override
  Future<Either<Failure, LoggedUserInfo>> call(
      LoginCredential credential) async {
    if (!credential.isValidPhone) {
      return Left(ErrorLoginPhone(message: "Invalid Phone number"));
    }

    var result = await service.isOnline();

    if (result.isLeft()) return result.map((r) => null);

    return await repository.loginPhone(phone: credential.phone);
  }
}
