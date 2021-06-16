import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';

abstract class LoginDatasource {
  Future<UserModel> loginEmail({String email, String password});

  Future<UserModel> loginPhone({String phone});
}
