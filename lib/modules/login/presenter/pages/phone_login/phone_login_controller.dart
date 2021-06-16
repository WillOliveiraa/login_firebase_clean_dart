import 'package:login_firebase_clean_dart/app/core/stores/auth_store.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/entities/login_credential.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/login_with_phone.dart';
import 'package:login_firebase_clean_dart/modules/login/presenter/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
part 'phone_login_controller.g.dart';

class PhoneLoginController = _PhoneLoginControllerBase
    with _$PhoneLoginController;

abstract class _PhoneLoginControllerBase with Store {
  final LoginWithPhone loginWithPhoneUsecase;
  final LoadingDialog loading;
  final AuthStore authStore;

  _PhoneLoginControllerBase(
      this.loginWithPhoneUsecase, this.loading, this.authStore);

  @observable
  String phone = "";

  @computed
  LoginCredential get credential =>
      LoginCredential.withPhone(phoneNumber: phone);

  @computed
  bool get isValid => credential.isValidPhone;

  @action
  setPhone(String value) => this.phone = value;

  enterPhone() async {
    loading.show();
    var result = await loginWithPhoneUsecase(credential);
    await loading.hide();

    result.fold((failure) {
      // if (failure is N)
    }, (user) {
      // authStore.se
    });
  }
}
