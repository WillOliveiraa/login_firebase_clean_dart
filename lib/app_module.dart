import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    ...LoginModule.export,
    Bind((i) => FirebaseAuth.instance),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: LoginModule()),
  ];
}
