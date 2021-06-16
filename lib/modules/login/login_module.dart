import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/app/core/stores/auth_store.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/get_logged_user.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_email.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_phone.dart';
import 'package:login_firebase_clean_dart/modules/login/external/datasources/firebase_datasource.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/pages/login/login_controller.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/pages/login/login_page.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/pages/phone_login/phone_login_controller.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/pages/phone_login/phone_login_page.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/utils/loading_dialog.dart';

// ignore: must_be_immutable
class LoginModule extends Module {
  static List<Bind> export = [
    Bind.singleton((i) => GetLoggedUserImpl(i())),
    Bind.singleton((i) => LoginRepositoryImpl(i())),
    Bind.singleton((i) => FirebaseDatasourceImpl(i())),
  ];

  @override
  List<Bind> binds = [
    Bind((i) => LoginController(
        i<LoginWithEmail>(), i<LoadingDialog>(), i<AuthStore>())),
    Bind((i) => PhoneLoginController(
        i<LoginWithPhone>(), i<LoadingDialog>(), i<AuthStore>())),
    Bind((i) => LoginWithEmailImpl(i())),
    Bind((i) => LoginWithPhoneImpl(i())),
    Bind((i) => LoadingDialogImpl()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('/phone', child: (_, args) => PhoneLoginPage()),
  ];
}
