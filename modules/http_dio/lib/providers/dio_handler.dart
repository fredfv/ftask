import 'dart:io';
import 'package:core/domain/application/http_custom_configurations.dart';
import 'package:core/domain/http_request_methods.dart';
import 'package:dio/dio.dart';

import '../helpers/logger.dart';


class DioHandler {
  Dio? _dio;

  void configureHeader(
    String baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    String? token,
  ) {
    fLog.w('[BASE URL] => $baseUrl');
    fLog.w('[CT & RT] => $connectTimeout / $receiveTimeout');

    Map<String, dynamic> header = {
      'Content-Type': 'application/json',
    };

    if (token != null) header["Authorization"] = 'Bearer $token';

    _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: header,
        connectTimeout: connectTimeout ?? HttpCustomConfigurations.connectTimeout,
        receiveTimeout: receiveTimeout ?? HttpCustomConfigurations.receiveTimeout));
  }

  void configureInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          fLog.w(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters}";
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          fLog.w("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          fLog.w("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> call({
    required String baseUrl,
    required String endPoint,
    required HttpRequestMethods method,
    dynamic params,
    int? connectTimeout,
    int? receiveTimeout,
    String? token,
  }) async {
    Response response;

    configureHeader(baseUrl, connectTimeout, receiveTimeout, token);
    configureInterceptors();

    try {
      if (method == HttpRequestMethods.post) {
        response = await _dio!.post(
          endPoint,
          data: params,
        );
      } else if (method == HttpRequestMethods.delete) {
        response = await _dio!.delete(endPoint);
      } else if (method == HttpRequestMethods.patch) {
        response = await _dio!.patch(endPoint);
      } else {
        response = await _dio!.get(endPoint, queryParameters: params);
      }

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      fLog.e(e);
      throw Exception("${e.message}Not Internet Connection");
    } on FormatException catch (e) {
      fLog.e(e);
      throw Exception("${e.message}Bad response format");
    } on DioError catch (e) {
      fLog.e(e);
      throw Exception(e.response);
    } catch (e) {
      fLog.e(e);
      throw Exception("Something wen't wrong");
    }
  }
}
