abstract class ResultData<T> {
  const ResultData();
}

class Success<T> extends ResultData<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends ResultData<T> {
  final String? errorMessage;

  const Failure(this.errorMessage);
}
