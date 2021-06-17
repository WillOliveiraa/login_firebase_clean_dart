import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';

abstract class VerifyPhoneCode {
  Future<Either<Failure, LoggedUserInfo>> call(LoginCredential credential);
}

class VerifyPhoneCodeImpl implements VerifyPhoneCode {
  final LoginRepository repository;

  VerifyPhoneCodeImpl(this.repository);

  @override
  Future<Either<Failure, LoggedUserInfo>> call(
      LoginCredential credential) async {
    if (!credential.isValidCode) {
      return Left(ErrorVerifyPhoneCode(message: "Invalid Code"));
    } else if (!credential.isValidVerificationId) {
      return Left(ErrorVerifyPhoneCode(message: "Invalid Verification Id"));
    }

    return await repository.verifyPhoneCode(
        code: credential.code, verificationId: credential.verificationId);
  }
}
