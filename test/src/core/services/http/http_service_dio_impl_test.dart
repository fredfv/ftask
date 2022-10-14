import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task/src/core/application/custom_exception.dart';
import 'package:task/src/core/infra/http_request_methods.dart';
import 'package:task/src/core/domain/services/http_service.dart';

class HttpServiceMock extends Mock implements HttpService {
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
    if (params != null) {
      return {'response': 'ok'};
    } else {
      return CustomException('Error mock');
    }
  }
}

void main() {
  final httpService = HttpServiceMock();

  test('should be a instance of HttpService', () {
    expect(httpService, isA<HttpService>());
  });

  test('should return a response', () async {
    final result = await httpService.request(
      baseUrl: 'https://www.google.com',
      endPoint: 'test',
      method: HttpRequestMethods.get,
      params: {'test': 'test'},
    );
    expect(result, {'response': 'ok'}, reason: 'Pass a param and return a response');
  });

  test('should return a exception', () async {
    final result = await httpService.request(
      baseUrl: 'https://www.google.com',
      endPoint: 'test',
      method: HttpRequestMethods.get,
    );
    expect(result, isA<CustomException>(), reason: 'Not pass a param and return a exception');
  });
}
