import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_firebase_clean_dart/app/core/stores/auth_store.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/verify_phone_code.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'verify_code_controller.g.dart';

class VerifyCodeController = _VerifyCodeControllerBase
    with _$VerifyCodeController;

abstract class _VerifyCodeControllerBase with Store {
  final VerifyPhoneCode verifyPhoneCode;
  final String verificationId;
  final LoadingDialog loading;
  final AuthStore authStore;

  _VerifyCodeControllerBase(this.verifyPhoneCode, this.loading, this.authStore,
      {@Param this.verificationId});

  @observable
  String code = "";

  @action
  setCode(String value) => code = value;

  @computed
  LoginCredential get credential => LoginCredential.withVerificationCode(
      code: code, verificationId: verificationId);

  @computed
  bool get isValid => credential.isValidCode;

  void enterCode() async {
    loading.show();
    await Future.delayed(Duration(seconds: 1));
    var result = await verifyPhoneCode(credential);
    await loading.hide();

    result.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.message)));
    }, (user) {
      // Modular.to.popUntil(ModalRoute.withName(Modular.to.modulePath));
      Modular.to.pop();
    });
  }
}
