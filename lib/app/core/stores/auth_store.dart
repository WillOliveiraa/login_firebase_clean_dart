import 'package:login_firebase_clean_dart/modules/login/domain/entities/logged_user_info.dart';
import 'package:login_firebase_clean_dart/modules/login/domain/usecases/get_logged_user.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final GetLoggedUser getLoggedUser;

  _AuthStoreBase(this.getLoggedUser);

  @observable
  LoggedUserInfo user;

  @computed
  bool get isLogged => user != null;

  @action
  void setUser(LoggedUserInfo value) => user = value;

  Future<bool> checkLogin() async {
    var result = await getLoggedUser();
    return result.fold((l) => null, (user) {
      setUser(user);
      return true;
    });
  }
}
