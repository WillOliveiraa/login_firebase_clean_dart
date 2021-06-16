import 'package:flutter_modular/flutter_modular.dart';
import 'splash_screen_page.dart';

class SplashScreenModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SplashScreenPage()),
  ];
}
