class ApiResult<T> {
  final T? data;
  final String? message;
  final String? error;

  ApiResult({this.data, this.message, this.error});

  bool get isSuccess => data != null && error == null;
}
