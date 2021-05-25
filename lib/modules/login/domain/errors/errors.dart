abstract class Failure implements Exception {
  String get message;
}

class ErrorLoginEmail extends Failure {
  final String message;
  ErrorLoginEmail({this.message});
}
