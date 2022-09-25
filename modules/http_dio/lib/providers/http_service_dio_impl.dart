import 'package:core/domain/application/custom_exception.dart';
import 'package:core/domain/application/http_request_methods.dart';
import 'package:core/domain/services/http_service.dart';
import 'package:dio/dio.dart';

import 'dio_handler.dart';

class HttpServiceDioImpl implements HttpService {
  final _requestHandler = DioHandler();

  @override
  Future<dynamic> request({
    required String baseUrl,
    required String endPoint,
    required HttpRequestMethods method,
    dynamic params,
    int? connectTimeout,
    int? receiveTimeout,
    String? token,
  }) async {
    try {
      final result = await _requestHandler.call(
        baseUrl: baseUrl,
        endPoint: endPoint,
        method: method,
        params: params,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        token: token,
      );
      if (result != null) {
        if (result is Response) {
          return result.data;
        }
      }
    } on Exception catch (error) {
      return CustomException(error.toString());
    } catch (error) {
      return CustomException('Something really unknown $error');
    }
  }
}
