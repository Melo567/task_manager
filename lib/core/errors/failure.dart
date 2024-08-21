abstract class Failure {
  abstract String message;
}

class LocalDatabaseFailure extends Failure {
  @override
  String message = "Erreur de database";
}
