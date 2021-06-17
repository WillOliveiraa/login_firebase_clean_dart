import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/errors/errors.dart';
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

  @override
  Future<UserModel> loginPhone({String phone}) async {
    var completer = Completer<AuthCredential>();
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: (auth) {
        completer.complete(auth);
      },
      verificationFailed: (e) {
        completer.completeError(e);
      },
      codeSent: (String c, [int i]) {
        // completer.completeError()
      },
      codeAutoRetrievalTimeout: (v) {},
    );

    var credential = await completer.future;
    var user = (await auth.signInWithCredential(credential)).user;

    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<UserModel> currentUser() async {
    var user = auth.currentUser;

    if (user == null) throw ErrorGetLoggedUser();

    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<void> logout() async {
    return await auth.signOut();
  }

  @override
  Future<UserModel> verifyPhoneCode(
      {String code, String verificationId}) async {
    var _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);

    var user = (await auth.signInWithCredential(_credential)).user;

    return UserModel(
        name: user.displayName,
        phoneNumber: user.phoneNumber,
        email: user.email);
  }
}
