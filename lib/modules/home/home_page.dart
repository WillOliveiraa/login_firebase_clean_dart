import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/app/core/stores/auth_store.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final authStore = Modular.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Observer(builder: (_) {
          return authStore.isLogged ? _getLoggedScreen() : _getLogoutScreen();
        }),
      ),
    );
  }

  Widget _getLoggedScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Logged!"),
        SizedBox(
          height: 10,
        ),
        if (authStore?.user?.email != null)
          Text("email: ${authStore?.user?.email}"),
        if (authStore?.user?.phoneNumber != null)
          Text("phone: ${authStore?.user?.phoneNumber}"),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => authStore.signOut(),
          child: Text("Logout"),
        ),
      ],
    );
  }

  Widget _getLogoutScreen() {
    return ElevatedButton(
      onPressed: () => Modular.to.pushNamed("/login"),
      child: Text("Login"),
    );
  }
}
