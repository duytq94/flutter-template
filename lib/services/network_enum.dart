import 'package:flutter_template/services/services.dart';

class NetworkEnum {
  NetworkEnum._();

  static const failToHostLookup = "Fail host lookup";
  static const noInternet = "No internet connection";
  static const timeoutConnection = "Timeout";
  static const canceledRequest = "Request has been canceled";
  static const errorServer = "An error from server";
  static const errorClient = "An error from client";
}

class AppExceptionCode {
  AppExceptionCode._();

  static const int unknown = 0;
  static const int timeoutConnection = 2;
  static const int canceledRequest = 3;
}
