import 'package:dartz/dartz.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';

abstract class ConnectivityService {
  Future<Either<Failure, Unit>> isOnline();
}
