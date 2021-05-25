import 'package:meta/meta.dart';

import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';

class UserModel extends LoggedUser implements LoggedUserInfo {
  UserModel({@required String name, String email, String phoneNumber})
      : super(name: name, email: email, phoneNumber: phoneNumber);

  LoggedUser toLoggedUser() => this;
}
