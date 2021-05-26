import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_email.dart';
import 'package:login_firebase_clean_dart/modules/login/external/datasources/firebase_datasource.dart';
import 'package:login_firebase_clean_dart/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/pages/login/login_page.dart';

// ignore: must_be_immutable
class LoginModule extends Module {
  static List<Bind> export = [
    Bind.singleton((i) => LoginRepositoryImpl(i())),
    Bind.singleton((i) => FirebaseDatasourceImpl(i())),
  ];

  @override
  List<Bind> binds = [
    Bind((i) => LoginWithEmailImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
  ];
}