class ApiException implements Exception {
  final int statusCode;
  final String error;

  ApiException(this.statusCode, this.error);

  @override
  String toString() {
    return 'ApiException: Status Code $statusCode, Error: $error';
  }
}