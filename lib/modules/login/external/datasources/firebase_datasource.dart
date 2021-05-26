import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/datasources/login_datasource.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/models/user_model.dart';

class FirebaseDatasourceImpl implements LoginDatasource {
  final FirebaseAuth auth;

  FirebaseDatasourceImpl(this.auth);

  @override
  Future<UserModel> loginEmail({String email, String password}) async {
    final result =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    final user = result.user;

    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }
}
