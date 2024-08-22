abstract class Failure {
  abstract String message;
}

class LocalDatabaseFailure extends Failure {
  @override
  String message = "Erreur de database";
}

class ObjectNotFoundFailure extends Failure {
  @override
  String message = "Object not found";
}
