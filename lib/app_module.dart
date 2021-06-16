import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/app/core/pages/splash/splash_screen_module.dart';
import 'package:login_firebase_clean_dart/app/core/stores/auth_store.dart';
import 'package:login_firebase_clean_dart/modules/home/home_module.dart';
import 'package:login_firebase_clean_dart/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    ...LoginModule.export,
    Bind((i) => FirebaseAuth.instance),
    Bind((i) => AuthStore(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute("/", child: (_, args) => SplashScreenPage()),
    ModuleRoute(Modular.initialRoute, module: SplashScreenModule()),
    ModuleRoute("/login", module: LoginModule()),
    ModuleRoute("/home", module: HomeModule()),
  ];
}
