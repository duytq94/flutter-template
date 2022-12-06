class AppException implements Exception {
  final String message;
  final int? errCode;

  AppException({this.message = "", this.errCode});

  @override
  String toString() {
    if (message.isNotEmpty) {
      return message;
    } else {
      return "AppException with empty message";
    }
  }
}
