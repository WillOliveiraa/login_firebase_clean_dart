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
