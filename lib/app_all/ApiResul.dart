// abstract class ApiResult<T> {
//   const ApiResult();
// }
//
// class Success<T> extends ApiResult<T> {
//   final T data;
//
//   const Success(this.data);
// }
//
// class Failure<T> extends ApiResult<T> {
//   final Exception exception;
//
//   const Failure(this.exception);
// }

abstract class ApiResult<T> {
  const ApiResult();

  // ✅ ضيف هذي الدالة
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(Exception exception) onFailure,
  ) {
    final self = this;
    if (self is Success<T>) {
      return onSuccess(self.data);
    } else if (self is Failure<T>) {
      return onFailure(self.exception);
    }
    throw StateError('Unknown ApiResult type: $self');
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final Exception exception;

  const Failure(this.exception);
}
