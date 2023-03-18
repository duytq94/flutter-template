abstract class Result {}

class Success<T> extends Result {
  final T data;

  Success(this.data);
}

class Failure extends Result {
  final String errMessage;

  Failure(this.errMessage);
}
