import 'package:checklist_app/data/const/response_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiProvider {
  ApiProvider(this.ref);

  final Ref ref;
  Dio dio = Dio();

  late Response response;

  Future<Response> postConnect(
    url, {
    String? apiToken,
    dynamic data,
    CancelToken? cancel,
  }) async {
    try {
      if (apiToken != null) {
        dio.options.headers['Authorization'] = 'Bearer $apiToken';
      }
      dio.options.baseUrl = 'http://94.74.86.174:8080/api';
      final baseURI = dio.options.baseUrl;
      response = await dio.post(
        '$baseURI$url',
        data: data,
        cancelToken: cancel,
      );
      return response;
    } on DioError catch (e) {
      return errorCatcher(e);
    }
  }

  Future<Response> getConnect(
    String url, {
    String? apiToken,
    CancelToken? cancelToken,
  }) async {
    try {
      if (apiToken != null) {
        dio.options.headers['Authorization'] = 'Bearer $apiToken';
      }
      return await dio.post(
        dio.options.baseUrl + url,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      return errorCatcher(e);
    }
  }

  Future<Response> destroy(
    String url, {
    String? apiToken,
    CancelToken? cancelToken,
  }) async {
    try {
      if (apiToken != null) {
        dio.options.headers['Authorization'] = 'Bearer $apiToken';
      }
      return await dio.delete(
        dio.options.baseUrl + url,
        cancelToken: cancelToken,
      );
    } on DioError catch (e) {
      return errorCatcher(e);
    }
  }

  Future<Response<dynamic>> errorCatcher(DioError e) {
    if (e.type == DioErrorType.response) {
      int? statusCode = e.response?.statusCode;
      if (statusCode == STATUS.NOT_FOUND) {
        throw MESSAGE.NOT_FOUND;
      } else if (statusCode == STATUS.INTERNAL_ERROR) {
        throw MESSAGE.INTERNAL_ERROR;
      } else {
        throw '${e.error.message}';
      }
    } else if (e.type == DioErrorType.connectTimeout) {
      throw MESSAGE.CONNECTION_TIMEOUT;
    } else if (e.type == DioErrorType.cancel) {
      throw 'cancel';
    }
    throw MESSAGE.DEFAULT;
  }
}
