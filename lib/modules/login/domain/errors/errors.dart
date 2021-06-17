abstract class Failure implements Exception {
  String get message;
}

class ErrorLoginEmail extends Failure {
  final String message;
  ErrorLoginEmail({this.message});
}

class ErrorLoginPhone extends Failure {
  final String message;
  ErrorLoginPhone({this.message});
}

class ErrorGetLoggedUser extends Failure {
  final String message;
  ErrorGetLoggedUser({this.message});
}

class ErrorLogout extends Failure {
  final String message;
  ErrorLogout({this.message});
}

class ErrorVerifyPhoneCode extends Failure {
  final String message;
  ErrorVerifyPhoneCode({this.message});
}

class NotAutomaticRetrieved implements Failure {
  final String verificationId;
  final String message;
  NotAutomaticRetrieved(this.verificationId, {this.message});
}
