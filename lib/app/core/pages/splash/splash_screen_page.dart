import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/app/core/stores/auth_store.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage() {
    Modular.get<AuthStore>().checkLogin().then((v) {
      return Future.delayed(Duration(seconds: 1));
    }).then((value) {
      Modular.to.pushReplacementNamed("/home");
      // Modular.to.pushNamedAndRemoveUntil("/home", (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
