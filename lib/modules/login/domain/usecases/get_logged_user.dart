import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/repositories/login_repository.dart';

abstract class GetLoggedUser {
  Future<Either<Failure, LoggedUserInfo>> call();
}

class GetLoggedUserImpl implements GetLoggedUser {
  final LoginRepository repository;

  GetLoggedUserImpl(this.repository);

  @override
  Future<Either<Failure, LoggedUserInfo>> call() async {
    return await repository.loggedUser();
  }
}
