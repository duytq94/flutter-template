import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'services.dart';

class DioApiClient extends BaseClient {
  final Dio _dio = Dio();

  DioApiClient(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("onRequest: url=${options.path}, path=${options.method}");
    return handler.next(options);
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("onResponse: ${response.statusCode}");
    return handler.next(response);
  }

  void _onError(DioError e, ErrorInterceptorHandler handler) {
    debugPrint("onError: statusCode=${e.response?.statusCode}, statusMessage=${e.response?.statusMessage}");
    return handler.next(e);
  }

  @override
  Future get(String url) async {
    try {
      final response = await _dio.get(url);
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
