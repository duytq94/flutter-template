import 'dart:convert';

import 'package:dio/dio.dart';

import 'services.dart';

class DioApiClient extends BaseClient {
  @override
  Future get(String url) async {
    try {
      final response = await Dio().get(url);
      final responseBody = response.data is Map || response.data is List
          ? response.data
          : response.data != ""
              ? jsonDecode(response.data)
              : response.data;
      return responseBody;
    } on DioError catch (error) {
      Response? errResponse = error.response;
      if (errResponse != null) {
        throw AppException(
          message: errResponse.statusMessage ?? "",
          errCode: errResponse.statusCode,
        );
      } else {
        switch (error.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
            throw AppException(message: NetworkEnum.timeoutConnection, errCode: AppExceptionCode.timeoutConnection);
          case DioErrorType.cancel:
            throw AppException(message: NetworkEnum.canceledRequest, errCode: AppExceptionCode.canceledRequest);
          default:
            throw AppException(message: error.message, errCode: AppExceptionCode.unknown);
        }
      }
    }
  }
}
