import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/services/connectivity_service.dart';

abstract class VerifyPhoneCode {
  Future<Either<Failure, LoggedUserInfo>> call(LoginCredential credential);
}

class VerifyPhoneCodeImpl implements VerifyPhoneCode {
  final LoginRepository repository;
  final ConnectivityService service;

  VerifyPhoneCodeImpl(this.repository, this.service);

  @override
  Future<Either<Failure, LoggedUserInfo>> call(
      LoginCredential credential) async {
    if (!credential.isValidCode) {
      return Left(ErrorVerifyPhoneCode(message: "Invalid Code"));
    } else if (!credential.isValidVerificationId) {
      return Left(ErrorVerifyPhoneCode(message: "Invalid Verification Id"));
    }

    var result = await service.isOnline();

    if (result.isLeft()) {
      return result.map((r) => null);
    }

    return await repository.verifyPhoneCode(
        code: credential.code, verificationId: credential.verificationId);
  }
}
